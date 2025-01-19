indieweb-bashblog
========

A single Bash script to create blogs; brought into the realm of the IndieWeb's favourite technologies.

I am a long time fan of the original bashblog by [cfenollosa](https://github.com/cfenollosa/bashblog); it is a "very, very simple way to post entries to a blog by using a public folder on my server, without any special requirements and dependencies". And works on GNU/Linux, OSX and BSD ;^)

*How simple? Just type `./bb.sh post` and start writing your blogpost.*

[![Tutorial video](https://dead.garden/blog/img/bashblog_tutorial_thumb.png)](https://dead.garden/blog/img/bashblog_tutorial.mp4)

What's new
-----
* adjusted the semantic HTML, avoiding divs and making it valid in the eyes of w3
* added basic [Microformats](https://indieweb.org/microformats)
* prompt creating code for one [Webmention](https://indieweb.org/webmention) before editing
* support for automatically sending said Webmention after posting
* support for displaying Webmentions on the page, using [webmention.js](https://github.com/PlaidWeb/webmention.js) 
* replaced default CSS with that of [bearblog](https://github.com/HermanMartinus/bearblog/)
* added [Open Heart](https://openheart.fyi/) protocol

[![](https://dead.garden/blog/img/bashblog_wm.png)](https://dead.garden/blog/img/bashblog_wm.png)

Tipps
----
I've found it's best to use this with Markdown, though HTML is also possible.

Be sure to run

    ./bb.sh rebuild

after posting; there are some errors that can come up after a post has been published (this is a general bashblog issue) but they are easily resolved like this.

Usage
-----

Download the code and copy bb.sh into a public folder (for example, `$HOME/public_html/blog`) and run

    ./bb.sh

This will show the available commands. If the file is not executable, type `chmod +x bb.sh` and retry.

**Before creating your first post, you may want to configure the blog settings (title, author, etc).
Read the Configuration section below for more information**

To create your first post, just run:

    ./bb.sh post
    
It will try to use Markdown, if installed. To force HTML:

    ./bb.sh post -html
    
The script will handle the rest.

When you're done, access the public URL for that folder  (e.g. `http://server.com/~username/blog`) 
and you should see the index file and a new page for that post!

Original Features
--------

- Ultra simple usage: Just type a post with your favorite editor and the script does the rest. No templating.
- No installation required. Download `bb.sh` and start blogging.
- Zero dependencies. It runs just on base utils (`date`, `basename`, `grep`, `sed`, `head`, etc)
- GNU/Linux, BSD and OSX compatible out of the box, no need for GNU `coreutils` on a Mac.
  It does some magic to autodetect which command switches it needs to run depending on your system.
- All content is static. You only need shell access to a machine with a public web folder.
  *Tip: advanced users could mount a remote public folder via `ftpfs` and run this script locally*
- Allows drafts, includes a simple but clean stylesheet, generates the RSS file automatically.
- Support for tags/categories
- Support for Markdown, Disqus comments, Twitter, Feedburner, Google Analytics.
- The project is still maintained as of 2016. Bugs are fixed, and new features are considered (see "Contributing")
- Everything stored in a single ~1k lines bash script, how cool is that?! ;) 


Configuration
-------------

Configuration is not required for a test drive, but if you plan on running your blog with bashblog, you will
want to change the default titles, author names, etc, to match your own.

There are two ways to configure the blog strings:

- Edit `bb.sh` and modify the variables in the `global_variables()` function
- Create a `.config` file with your configuration values -- useful if you don't want to touch the script and be able to update it regularly with git

The software will load the values in the script first, then overwrite them with the values in the `.config` file.
This means that you don't need to define all variables in the config file, only those which you need to override
from the defaults.

The format of the `.config` file is just one `variablename="value"` per line, just like in the `global_variables()`
function. **Please remember:** quote the values, do not declare a variable with the dollar sign, do not use 
spaces around the equal sign.

bashblog uses the `$EDITOR` environment value to open the text editor.


License
-------

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
