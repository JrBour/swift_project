#Installation du projet

## Cocoapods

Lorsque vous allez cloner le fichier, il faut que vous ayez installé le gestionnaire de dépendance cocoapods ([https://cocoapods.org/](https://cocoapods.org/))
Lorsque cela est fait, accédez au projet depuis le terminal, et fait un `pod install`. Ce qui permettra de générer les dépendances grâce au podfile.lock.


## Ouverture du projet

Il vous faut lancer le fichier `.xcworkspace`, il semblerait que lorsque l'on utilise cocoapods, nous ne pouvons passer que par ce fichier et non pas par le `.xcodeproj`

## Organisation

Chacun se mettra sur sa propre branche, nous nous organiserons au mieux en ce qui concerne les storyboards. D'après certains articles, les développeurs swift, font en sorte de créer un storyboard par controller ([How real teams deal with iOS Storyboards](https://medium.com/practical-ios-development/how-real-teams-deal-with-ios-storyboards-beb8bb4c2765))

N'oubliez pas d'utilisez le système de MVC (Model View Controller), petit rappel : [Utilisez le modèle MVC](https://openclassrooms.com/courses/developpez-une-app-pour-ios/utilisez-le-modele-mvc)

##Raccourci pratique
* **cmd+r** = Build et lance le projet sur le simulateur
* **cmd+b** = Build le projet afin de voir les erreurs qui se produiront lors de l'exécution de l'application
* **cmd+shift+k** = Clean le projet (permet de résoudre certaines erreurs)
* **shift+cmd+o** = Ouvre le "spotlight" de Xcode, et permet de faire une recherche rapide

##Liens utile
* [**Documentation Swift**](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/)
* [**Format Ibooks**](https://www.apple.com/fr/swift/)
