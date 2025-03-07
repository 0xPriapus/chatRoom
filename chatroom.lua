MEMBERS = MEMBERS or {}

Handlers.add(
    "Register",
    Handlers.utils.hasMatchingTag("Action", "Register"),
    function (msg)
      table.insert(MEMBERS, msg.From)
      Handlers.utils.reply("registered")(msg)
    end
  )

-- Handlers.add(
--     "Broadcast",
--     Handlers.utils.hasMatchingTag("Action", "Broadcast"),
--     function (msg)
--       for _, recipient in ipairs(MEMBERS) do
--         ao.send({Target = recipient, Data = msg.Data})
--       end
--       Handlers.utils.reply("Broadcasted.")(msg)
--     end
--   )

Handlers.add(
    "Broadcast",
    Handlers.utils.hasMatchingTag("Action", "Broadcast"),
    function(m)
        if Balances[m.From] == nil or tonumber(Balances[m.From]) < 1 then
            print("UNAUTH REQ: " .. m.From)
            return
        end
        local type = m.Type or "Normal"
        print("Broadcasting message from " .. m.From .. ". Content: " .. m.Data)
        for i = 1, #MEMBERS, 1 do
            ao.send({
                Target = MEMBERS[i],
                Action = "Broadcasted",
                Broadcaster = m.From,
                Data = m.Data
            })
        end
    end
)
