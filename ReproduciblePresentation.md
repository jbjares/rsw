Presentation
========================================================
author: Joao Bosco Jares
date: 18/05/2015

Non-Automated Part - clone project
========================================================
- To start, you need to clone the support java project from github, as URL to the video below: 
https://drive.google.com/file/d/0By2jTQ9xDwq-b0dQMFE2YWxydHc/view?usp=sharing

PS.: Maven3 must be pre-installed too.


Automated Part - Build and Install rJava - Part 1
========================================================
- You probably have copied the jsw project folder path. If yes, it's time to use it :)
So, use the code below to start the integration process.

```r
source("javaCompileAndPackageToRFolder.R")
```

Automated Part - Build and Install rJava - Part 2
========================================================
- After, you have started this process, some questions will be made by the system.
- The first question is regards the JAVA_HOME folder path. If you just press enter the system will input the folder path of my own installation (not seems good). So, inform the correct path and don't worry. The question seems as below:

```
If your JAVA_HOME is different from that 
 C:/Program Files/Java/jdk1.7.0_71/jre, please input below, else press enter:
```

Automated Part - Build and Install rJava - Part 3
========================================================
- The second question is regards the cloned project folder path. If you just press enter the system will input the folder path of my own installation (not seems good). So, inform the correct path (just copy and paste) don't worry. The question seems as below:


```
Please, inform the cloned project location:
```

Automated Part - Build and Install rJava - Part 4
========================================================
- Now, your r environment should contains the generated .jar, named "MassGen-0.0.1-SNAPSHOT.jar", as well as, a lib folder with all his dependencies. Why you don't take a look?
- Is there? Great!!!


Automated Part - Extract Data - Part 1
========================================================
- We did all these steps, because I believe that Java is more productive than R to this kind of job. No problem if I'm wrong. If I'm I'll learn, and say you ASAP :)

- Ok. And now? We'll use the support java code. First, you need to import using source the javaCompileAndPackageToRFolder.R, as below:

```r
source("ExtractAndGenMass.R")
```
- Why this file starts with an uppercase letter? I'm using this pattern for classes and lowercase to start a script name (needs some code refactoring soon).

Automated Part - Extract Data - Part 2
========================================================
- This class makes reference to the four scripts who call the java methods properly. Extracting and generating each necessary file to integrate our first full dataset.
- You can take a look in this interesting class, who has four methods, all of them are called by the class in the final lines, as below:


```r
ExtractMass$codeAndCountyExtract()
ExtractMass$basicDataExtract()
ExtractMass$geoLocDataExtract()
ExtractMass$playGen()
```

Automated Part - Extract Data - Part 3
========================================================
- Goes to itunes sales site, main page, then extract all country's code to retrieve his content.

```r
ExtractMass$codeAndCountyExtract()
```

Automated Part - Extract Data - Part 4
========================================================
- Goes to itunes sales site, and using the gathered data on the first process, uses each gathered code to retrieves the data by country.

```r
ExtractMass$basicDataExtract()
```

Automated Part - Extract Data - Part 5
========================================================
- Uses the country names retrieved for the second script and calls "Google Geocoding" to gather latitude and longitude for each related country.

```r
ExtractMass$geoLocDataExtract()
```

Automated Part - Extract Data - Part 6
========================================================
-The last method is resposible for assembly all gathered data into "Play Action" object then save it on mongoDB.

```r
ExtractMass$playGen()
```

Automated Part - Extract Data - Part 7
========================================================
- It's important to say that each method makes questions regards if you want to update or not the existing file, once for each call (less for the last one), one .csv file is generated into R workspace. As well as, is good to know that the call order matters are important, once each script depends of the data gathered by the previous one.
- In the final, you must have iTunesCodesAndCountries.csv, geoLoc.csv, and basicData.csv into your workspace. Perhaps them can be moved for a properly data warehouse, once all the interaction will be interfacing with mongo after the last method call. So, they maybe can called as temp files.


Main classes cover
========================================================
- We have a huge topic related to code organization, or disorganization :) But, Is necessary to point that after this moment we'll interact more with swDAO.R and presentationView.R classes to start our generation's work. Just a brief, the first class take care of the mongo access and the second one deal with graphic methods.
Ps.: All of them uses the global.R script to initialize libraries, define constants, create cache variables, as well as, other utilities. Please, feel free to take a look on the repository at https://github.com/jbjares/rsw.git


Creating our data.frame base on the memory
========================================================






