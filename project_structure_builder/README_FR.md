# 📦 Générateur de Structure de Projet - Documentation

**Note** : Ne l'utilisez que lors de la création de votre projet. Il ne sert qu'à générer une base de fichiers et de ressources afin de ne pas avoir à la créer soi-même, d'autant plus qu'il est fastidieux de copier-coller ou de refaire les mêmes choses d'un projet à l'autre. Si les fichiers et architectures générés ne vous conviennent pas, vous pouvez les modifier après génération sans soucis. Vous pouvez également modifier le package et le soumettre pour aider d'autres personnes.

## 📌 Installation

Ajoutez le package `project_structure_builder` aux `dev_dependencies` de votre projet Flutter :

```yaml
flutter pub add --dev project_structure_builder
```

Ou en modifiant directement votre fichier `pubspec.yaml` :

```yaml
dev_dependencies:
  project_structure_builder: latest_version
```

Ou encore :

```yaml
dependencies:
  flutter:
    sdk: flutter

dev_dependencies:
  project_structure_builder:
    git:
      url: https://github.com/BaHithBENON/flutter_project_structure_builder.git
      ref: main
      path: project_structure_builder
```

Puis exécutez :

```bash
flutter pub get
```

## 🛠️ Configuration du Projet

Créez un fichier `project_structure_builder.yml` à la racine de votre projet Flutter et ajoutez-y la configuration suivante en fonction de vos besoins :

### Exemple de fichier de configuration :

```yaml
# Ceci est un exemple. Modifiez les valeurs selon vos besoins.

# Nom du projet
project_name: mon_application_flutter

# Options d'architecture disponibles :
#   - clean_architecture (par défaut)
#   - mvc_architecture
#   - mvvm_architecture
architecture: mvc_architecture

# Options disponibles pour la stratégie de gestion des fonctionnalités :
#   - inLib (par défaut) : toutes les fonctionnalités sont dans le même dossier `lib`
#   - independantModules : chaque fonctionnalité dispose de ses propres modules Flutter pour les couches domaine et données. La couche présentation reste dans le dossier `lib` principal du projet.
#
# Remarque : L'option "independantModules" est uniquement disponible pour `clean_architecture`.
features_strategy: independantModules

# Liste des fonctionnalités :
features:
  - authentication: # Nom de la fonctionnalité (format snake_case)
      
      name: authentication # Redéfinition du nom de la fonctionnalité
      
      # Description de la fonctionnalité
      description: Fonctionnalité d'authentification
      
      # Liste des attributs de l'entité de la fonctionnalité (optionnel)
      # Si vous n’avez pas d’attributs, vous pouvez ignorer cette section.
      entity_attributes:
        email: String # Format : { nom_de_l_attribut: type }
        otp: String
        password: String
        token: String
        id: int
      
      # Liste des cas d'utilisation
      usecases:
        - getUserOtp: # Nom du cas d'utilisation
            use_case_type: Future # Type de retour du cas d'utilisation (Future ou Stream)
            description: Récupérer l'OTP pour l'authentification utilisateur
            params: # Liste des paramètres du cas d'utilisation
              email: String # Format : { nom_du_paramètre: type }
        - verifyUserOtp:
            use_case_type: Future
            description: Vérifier le code OTP
            params:
              email: String
              otp: String
        - verifyUserExistence:
            use_case_type: Future
            description: Vérifier l'existence de l'utilisateur

# Gestion de l'état
# Par défaut, la gestion de l'état est GetX
# Options disponibles pour le moment : none, getx
# Remarque : Seuls "none" et "getx" sont disponibles pour le moment.
state_management: none

# Liste des environnements :
envs:
  - development
  - staging
  - production

# Liste des variables d'environnement
# Ne mettez pas de données sensibles (seulement les noms des variables)
env_variables:
  - ENV1
  - ENV2
```

## 🔍 Explication des Paramètres

### **📌 Nom du projet**
```yaml
project_name: mon_application_flutter
```
Définit le nom du projet Flutter.

### **🛠️ Architecture**
```yaml
architecture: mvc_architecture
```
Définit l’architecture du projet.
Options disponibles :
- `clean_architecture` (par défaut)
- `mvc_architecture`
- `mvvm_architecture`

### **📂 Stratégie de gestion des fonctionnalités**
```yaml
features_strategy: independantModules
```
Définit l'organisation des fonctionnalités dans le projet.
- `inLib` : Toutes les fonctionnalités sont regroupées dans `lib/`.
- `independantModules` : Chaque fonctionnalité a ses propres modules.

> **Remarque** : `independantModules` est uniquement disponible pour `clean_architecture`.

### **🚀 Liste des Fonctionnalités**

```yaml
features:
  - authentication:
      name: authentication
      description: Fonctionnalité d'authentification
      entity_attributes:
        email: String
        otp: String
        password: String
        token: String
        id: int
      usecases:
        - getUserOtp:
            use_case_type: Future
            description: Récupérer l'OTP pour l'authentification utilisateur
            params:
              email: String
        - verifyUserOtp:
            use_case_type: Future
            description: Vérifier le code OTP
            params:
              email: String
              otp: String
        - verifyUserExistence:
            use_case_type: Future
            description: Vérifier l'existence de l'utilisateur
```
- Types d'attributs et de paramètres pris en charge : `String, int, double, num, bool, List, Set, Map, DateTime, Duration, Object, dynamic, void`. Si un type n´est pas reconnu, le type sera dynamic lors de la génération.
- Types de retour des fonctions (`Future` ou `Stream`)

### **📊 Gestion de l’État**
```yaml
state_management: none
```
Options disponibles :
- `none`
- `getx` (par défaut)

### **🔧 Environnements**
Définissez les environnements disponibles. Il est recommandé d'avoir au moins un environnement de développement.
```yaml
envs:
  - development
  - staging
  - production
```

### **🏢 Variables d’Environnement**
```yaml
env_variables:
  - ENV1
  - ENV2
```
Ne pas inclure de données sensibles ici !

---

## 🚀 Générer la Structure du Projet

Exécutez la commande suivante pour générer la structure du projet :

```bash
dart run project_structure_builder update
```

Cela analysera le fichier de configuration et structurera automatiquement le projet selon les paramètres définis.

---

## 🎯 Conclusion

Avec cette configuration, votre projet Flutter sera bien structuré et organisé selon les meilleures pratiques. 🚀

Si vous avez des questions, n’hésitez pas à consulter la documentation officielle ou à ouvrir une issue sur le dépôt GitHub ! 🎯

