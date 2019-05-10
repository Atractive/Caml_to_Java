# Caml_to_Java

## Objectifs
Le but de ce projet est de proposer un ensemble de script permettant, dans un premier temps de compiler et de traduire une suite d'instruction Caml en Java, puis d'éxécuter cette traduction avec Java.

## Historique
### 50 commits 
  - Caml  
    -> Ajout des fichiers de départ  
    -> Mise en place du "parser.mly"  
    -> Ajout de la fonction "exec" dans "instr.ml"  
  - Java  
    -> Mise en place des fichiers "config.java"  
    -> Ajout des classes Java  
  - Caml  
    -> Ajout de la fonction "compile"  
    -> Ajout de la fonction "print_gen_class_to_java"  
    -> *Make accepté*  
    -> *./comp accepté*  
  - Ajout des éléments supplémentaires, notamment la gestion des fonctions récursives  
  - Correction des fonctions  
   -> *Tests acceptés*  
  - Commentaires

## Compilation et Execution
Il faut se placer dans le dossier du projet :
```
cd Caml_To_Java
```
Puis il faut commencer par le "make" :
```
cd caml_files
make
```
Puis on doit générer le fichier Java :
```
cd ../
./caml_files/comp/ "caml_files/tests/test.ml" "java_files/Gen.java"
```
Enfin on doit compiler les fichiers Java et éxécuter le "Main.java" :
```
javac java_files/*.java  
javac java_files/Main.java
```

## Tests
Tous les tests sont concluants :
 1. Pour "ackermann_iter.ml" -> 29  
 2. Pour "ackermann_trad.ml" -> 29  
 3. Pour "even_odd.ml"       -> false  
 4. Pour "test.ml"           -> 6  

## Difficultés Rencontrés
J'ai rencontré plusieurs problèmes pendant la réalisation du projet :  
 - En premier lieu, j'ai eu beaucoup de problème à comprendre le fonctionnement de la fonction "compile", notamment au niveau de la partie récursive et de la partie pour les variables nécéssitant la création de fonction annexe. J'ai également eu beaucoup de problème pour comprendre le fonctionnement de la fonction "print_gen_class_to_java".  
 - Puis j'ai eu beaucoup de problème dans la création des classes java, notamment un problème sur ma machine virtuelle qui refusait la classe LLE sans raison compréhensible, m'empéchant ainsi de réaliser des tests.  
 - J'ai également eu énormement de problème de "cast" entre les différents types (IntV, NullV, etc...) qui résultaient de l'ordre dans lequel je dépilais et empilais les éléments de mon code dans la config.  

## Post Scriptum
La partie Caml a été réalisé sur ma machine personnel sur Windows 10.  
La partie Java a été réalisé sur une machine virtuelle ubuntu.  
*Je tiens enfin à remercier mon camarade Matthias Ambroise qui a su me donner énormement d'indications et quelques morceaux de son script afin de me débloquer et de me permettre d'avancer. Il est donc normal que la structure global du code ainsi que certaine partie du code sont identiques au sien. En espérant que cela ne vous dérange pas.*
