local resourceName = "CARJOB" 

PerformHttpRequest("https://api.github.com/repos/votre_nom_utilisateur/votre_repo/releases/latest", function(err, text, headers)
    Citizen.Wait(5000)
    if text then
        local info = json.decode(text)
        local currentVersion = GetResourceMetadata(resourceName, "version")
        local newestVersion = info.tag_name

        print("  //\n  ||    " .. resourceName .. " est créé par " .. info.author.login .. "\n  ||")

        if newestVersion ~= nil then
            if newestVersion ~= currentVersion then
                print("  ||    Version actuelle : ^1" .. currentVersion .. "^0")
                print("  ||    Dernière version : ^2" .. newestVersion .. "^0\n  ||")
                print("  ||    ^1Une mise à jour est disponible pour " .. resourceName .. ", visitez " .. info.html_url .. " pour obtenir la dernière version.\n^0  \\\\")
            else
                print("  ||    Version actuelle : ^2" .. currentVersion .. "^0")
                print("  ||    Dernière version : ^2" .. newestVersion .. "^0\n  ||")
                print("  ||    ^2" .. resourceName .. " est à jour !\n^0  \\\\")
            end
        else
            print("  ||    ^1Une erreur s'est produite lors de la récupération des informations de la dernière version.\n^0  \\\\")
        end
    end
end)