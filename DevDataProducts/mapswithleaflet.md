Better, faster, stronger ... leaflet-er
================
José Antonio García Ramirez

Previous work and context
-------------------------

In July 2016 in Mexico a call was opened to be part of the first data laboratory to improve the creation and management of public policy, [datalab](https://datos.gob.mx/blog/abrimos-convocatoria-datalab?category=noticias), and I participated. Part of the selection process consisted in solving a problem with data. The context of the problem is as follows:

In the prelude to Hurricane [Patricia](https://en.wikipedia.org/wiki/Hurricane_Patricia) in [Nayarit](https://en.wikipedia.org/wiki/Nayarit), a data set was collected about information of community centers (which serve as an emergency shelter incluying it's spatial location) distributed throughout the entity, data are provided by the institution that made the contest but are available in my [git](https://github.com/fou-foo/DataLab/blob/master/datalab.md) along with the analysis I made (the document is in Spanish), **it's required that anyone can see which community centers are closest to their location.** An important point of the competition was the visualization of the results, in that time the best visualization that I could did was the following:

![First map for k cluster](/home/fou/Desktop/Online/RCoursera/R-Coursera/DevDataProducts/mapaviejo1.png)

Where the blue dot is the location of a person requesting information from the nearest, randomly generated shelters, green spots at the nearest shelters and red spots at other shelters.

Now with the skills learned my challenge is to improve this visualization using the *leaflet* package
