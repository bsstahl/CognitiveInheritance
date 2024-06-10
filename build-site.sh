#!/usr/bin/bash
./FavGen/FavGen.exe "./" "./Pages/Favorites.md"
./PPTail/PPTail.exe "Provider=PPTail.Data.Forestry.Repository;FilePath=./" "Provider=PPTail.Output.FileSystem.Repository;FilePath=./docs" "Provider=PPTail.Templates.Yaml.ReadRepository;FilePath=./Templates"
