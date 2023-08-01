Config = {}

Config.UseOldEsx = true -- true for OLD, false for NEW

Config.OKOKNotify = true -- Si Config.OKOKNotify est sur true, les notifications "okokNotify" seront utilisées.

Config.UseESXDefaultNotify = false -- Si Config.OKOKNotify est sur false, cette option permet d'utiliser les notifications de base de ESX.

Config.CheckTime = 1000 -- Intervalle de vérification - NE PAS TOUCHER POUR UNE BONNE OPTIMISATION / Checking interval - DO NOT TOUCH FOR GOOD OPTIMIZATION

Config.Language = "fr" -- Language Fr or EN

Config.ListeJobs = {
    police = {
        label = "Police",
        vehicles = {
            "police",    -- Nom du véhicule / Vehicle name
            "police2",   
            -- Ajoutez d'autres véhicules ici / Add other vehicles here
        }
    },
    ambulance = {
        label = "Ambulance",
        vehicles = {
            "ambulance",    
            "ambulance2",   
            
        }
    },
    mechanic = {
        label = "Mécanicien",
        vehicles = {
            "flatbed",    
           
        }
    },
    taxi = {
        label = "Taxi",
        vehicles = {
            "taxi",    
            
        }
    },
    -- Ajoutez d'autres jobs et leurs véhicules associés ici / Add other jobs and their associated vehicles here
}