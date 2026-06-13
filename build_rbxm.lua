--[[
    CodeAssist RBXM Build Instructions
    Manual instructions to create the .rbxm plugin file
]]

print([[
=== CodeAssist RBXM Build Instructions ===

Pour créer le fichier .rbxm du plugin CodeAssist, suivez ces étapes dans Roblox Studio:

ÉTAPE 1: Préparer les fichiers
Assurez-vous que tous les fichiers Lua sont dans le dossier plugin/
- CodeAssist.lua (fichier principal)
- AdvancedAI.lua
- Settings.lua
- PatternLearning.lua
- SpecializedModules.lua
- HelpSystem.lua
- Utilities.lua

ÉTAPE 2: Créer le plugin dans Roblox Studio
1. Ouvrir Roblox Studio
2. Créer un nouveau place
3. Dans le Explorer, faire clic droit sur "Plugins"
4. Sélectionner "Create Plugin" ou importer les fichiers

ÉTAPE 3: Ajouter les fichiers ModuleScript
1. Dans le plugin créé, ajouter chaque fichier comme ModuleScript
2. Copier le contenu de chaque fichier .lua dans les ModuleScripts correspondants
3. Assurez-vous que les noms correspondent exactement

ÉTAPE 4: Configurer la clé API
1. Dans le plugin, ajouter un ModuleScript appelé "Config"
2. Ajouter votre clé API Groq: local API_KEY = "gsk_xxxxxxxx"

ÉTAPE 5: Exporter en .rbxm
1. Faire clic droit sur le Plugin dans le Plugin Manager
2. Sélectionner "Save to File"
3. Choisir le format .rbxm
4. Sauvegarder comme "CodeAssist.rbxm"

ÉTAPE 6: Tester le plugin
1. Importer le fichier .rbxm dans Roblox Studio
2. Activer le plugin dans Plugin Manager
3. Tester les fonctionnalités avec votre clé API

Le plugin est maintenant prêt à être partagé et installé!

Note: La clé API que vous avez configurée dans .env sera utilisée automatiquement par le plugin.
]])

print("Instructions affichées. Suivez les étapes ci-dessus dans Roblox Studio.")
