Watir-scripts for Tridion
=========================

Watir-project to automate testing of Tridion 2009 SP1 and 2011/2011 SP1. Very useful for automating testing for Event System, GUI Extensions or benchmarking the performance of the GUI for a single user. Can also be potentially used to automate testing on a wider scope (i.e. automatically create content, publish it, check the results on the front-end).

The project provides a simple framework (very much WIP) and some example scripts for performing the basic actions in Tridion 2009 SP1 and 2011 SP1.

Requirements
------------

- Ruby 1.9.3 (Probably works on older versions as well but not tested)

- Ruby DevKit (on Windows)

- Bundler (or install the gems manually)

- For 2011 scripts Chrome Webdriver and Chrome extension for enabling Basic HTTP Authentication in URL (http://code.google.com/p/url-embedded-auth/)

Installation
------------

- Run "bundle install"

- Modify utils.rb in both folders (2009 and 2011) to point to your CM-environments

- For 2011 example scripts you need to set username and password (in cm_navigation_2011.rb and modify_component_2011.rb)

- For 2011 scenarios install Chrome Webdriver to your PATH and modify the scenario-scripts to get the Chrome-extension for HTTP Authentication in URL from a correct folder, i.e. change "--load-extension=D:\Development\WatirBenchmarking\2011\ChromeExtension" to the location of the extension.

- Done!

Usage
-----

- Run a desired example case (e.g. "ruby modify_component_2011.rb")

- Build your own cases using the classes for corresponding CMs

Known issues
------------

- Popups on in Tridion 2009 and Watir don't work if there are any existing IE-windows open when starting the script

- The 2011 script opens the CME twice. This is because the first time it saves the credentials to the session by opening the CM with credentials in the URL, the second time is done because Tridion doesn't work correctly if the URL contains the credentials.

- The 2009 scripts should be run with a user that has access to Tridion. If its not possible you have to edit the scripts to include username and password in the URL like in 2011 scripts. You also need to change registry keys, see instruction from here: http://support.microsoft.com/kb/834489 ("How to disable the new default behavior for handling user information in HTTP or HTTPS URLs")

- Some actions are slow. This is due to the huge amount of IFrames in Tridion and Watir-webdriver being slow to parse the content in IFrames (Watir is fast though). This can be optimized by a certain degree by knowing the exact XPath to the elements. Might cause some headache if doing performance testing but can be worked around by timing how long the loading takes rather than how long the script takes to click on an element.


Author
-------

Vesa Paakkanen

License
-------

Licensed under the MIT License.