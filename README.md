buzztrack
=========

Buzzpoint tracking for quizbowl

This is a start at integrating buzzpoint tracking into quizbowl packets. A packet of tossups is first encoded using
the given XML schema. (see here for a sample XML packet: 
  http://csclub.uwaterloo.ca/~hzafar/buzzpoints/veto2012/waterlooa_tossups.xml)

The XML file is then converted into an HTML packet using the XSLT file, for example:

> xsltproc style.xsl tossups.xml > tossups.html

The REQUIRE folder and its contents must be put in the same place as the resulting HTML file. The file can then be 
opened and read from in any* browser, no Internet required. 
  (*Only Firefox and Chrome have been tested, though.)


SAMPLE PACKET: http://csclub.uwaterloo.ca/~hzafar/buzzpoints/veto2012/waterlooa_tossups.html

TO USE: Click on the word that a player buzzes in on. The entire clue corresponding to that word will be highlighted.
After one click, the clue will be blue, indicating a correct buzz. Another click will turn the clue red, indicating
a neg. A third click will turn it brown, indicating the same clue was negged on and answered correctly with (i.e. if
a team negs and the other immediately picks up the tossup). A fourth click will return the clue to normal.

When the packet has been read through and all tossups marked (dead tossups may have no marks), click the "generate stats"
link at the top or bottom of the page to generate an XML of the buzzpoints.
