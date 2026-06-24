# Redmine Risks

Plugin Redmine de gestion des risques projet — suivi du cycle de vie complet des risques, de l'avant-vente à la clôture du projet.

## Fonctionnalités

- **Registre des risques** par projet avec titre, description, cause, conséquence, responsable et statut
- **Double évaluation** : score initial (avant-vente) et score actuel, calculés à partir de la probabilité × impact (échelle 1–5)
- **Tendance automatique** : visualisation si le risque est en hausse ▲, stable ●, ou en baisse ▼
- **Historique des réévaluations** : chaque comité projet peut enregistrer une nouvelle évaluation avec commentaire et décision, sans écraser les données précédentes
- **Actions de mitigation** : associez des actions à chaque risque (réduire probabilité, réduire impact, transférer, accepter) avec responsable, échéance et lien vers un ticket Redmine
- **Tableau de bord** : KPIs projet — risques ouverts, critiques, en hausse, revues en retard, risques sans action
- **Niveaux de criticité** codés par couleur : faible / modéré / élevé / critique
- Traductions **français** et **anglais**

## Compatibilité

| Composant | Version |
|-----------|---------|
| Redmine   | ≥ 5.0   |
| Ruby      | ≥ 3.2   |
| Rails     | 7.x     |

## Installation

```bash
# 1. Cloner le plugin dans le dossier plugins de votre Redmine
cd /path/to/redmine
git clone https://github.com/kolialebuocq/redmine_risks plugins/redmine_risks

# 2. Exécuter les migrations
bundle exec rake redmine:plugins:migrate RAILS_ENV=production

# 3. Redémarrer Redmine
```

## Activation par projet

1. Aller dans **Paramètres** du projet → onglet **Modules**
2. Cocher **Risques**
3. Enregistrer

L'onglet **Risques** apparaît alors dans la navigation du projet.

## Matrice de criticité

| Score | Niveau   |
|-------|----------|
| 1–4   | Faible   |
| 5–9   | Modéré   |
| 10–14 | Élevé    |
| ≥ 15  | Critique |

Le score est calculé : **Probabilité × Impact** (chaque dimension cotée de 1 à 5).

## Désinstallation

```bash
bundle exec rake redmine:plugins:migrate NAME=redmine_risks VERSION=0 RAILS_ENV=production
rm -rf plugins/redmine_risks
```

## Licence

MIT
