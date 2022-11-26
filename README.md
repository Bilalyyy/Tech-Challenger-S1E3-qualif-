# Tech-Challenger-S1E3 (qualif)
## Exercice :
*Analyser des milliers de lignes.*
### Enoncé : 
Eco-planification
Vous vous faites vite remarquer au sein de la Brigade. Depuis le sauvetage du vieil homme vous avez été un des éléments les plus prometteurs de l'Ordre. Mais durant vos missions, vous avez remarqué qu'un méta-humain très puissant va plus vite que vous, et anticipe encore mieux que la Brigade certaines catastrophes...  
Vous n'en parlez pas encore à votre direction, mais vous lancez vos recherches sur ce mystérieux bienfaiteur inconnu de la Brigade. Dans votre quête, vous remarquez un motif étrange : il semblerait que celui-ci se déplace en minimisant à tout prix son empreinte carbone.  
Pour commencer vos recherches, vous décidez de vous concentrer uniquement sur les trajets de navette téléportatrice entre Paris et Lyon, et plus spécifiquement sur les allers-retours Paris-Lyon-Paris. Après tout, il y a de bonnes chances pour que l'élu emprunte ce trajet dans les semaines à venir, et vous disposez de données très précises sur la fluctuation de l'empreinte carbone de ces navettes.  
En vous basant sur le tableau des horaires des navettes à téléportation de la journée et leur empreinte carbone associée, parviendrez-vous à identifier le trajet aller-retour qui aura le plus faible impact environnemental ?  
### Données entrée :
Une chaine de charactere multiligne, la premiere ligne est entier N représentant le nombre de trajets dans la journée. Les lignes suivantes sont la description d'un trajet :  
l'heure de départ au format ```hh:mm:ss>```, la direction ```Lyon-Paris ou Paris-Lyon``` puis l'empreinte ```0...10^9``` carbone du trajet, séparées par des espaces.  
**L'entrée peut contenir entre 3 et 86 400 ligne**
### Exemple :
``` 
6
22:55:14 Lyon-Paris 1595  
16:33:17 Paris-Lyon 231  
10:15:04 Lyon-Paris 258  
11:28:21 Paris-Lyon 865  
09:30:54 Paris-Lyon 1332  
16:31:40 Lyon-Paris 350  
```
La réponse est : ```1215``` Ce trajet correspond aux lignes ```11:28:21 Paris-Lyon Paris-Lyon 865``` et ```16:33:17 Paris-Lyon 231```.  
D'autres trajets plus économes existent dans le sens Lyon-Paris-Lyon, mais on recherche uniquement des trajets Paris-Lyon-Paris
