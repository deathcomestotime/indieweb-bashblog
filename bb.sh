#!/usr/bin/env bash

# BashBlog, a simple blog system written in a single bash script
# (C) Carlos Fenollosa <carlos.fenollosa@gmail.com>, 2011-2016 and contributors
# https://github.com/carlesfe/bashblog/contributors
# Check out README.md for more details

# Global variables
# It is recommended to perform a 'rebuild' after changing any of this in the code

# Config file. Any settings "key=value" written there will override the
# global_variables defaults. Useful to avoid editing bb.sh and having to deal
# with merges in VCS
global_config=".config"

# This function will load all the variables defined here. They might be overridden
# by the 'global_config' file contents
global_variables() {
    global_software_name="BashBlog - Indieweb Version"
    global_software_version="1.0"
    
    global_lang="en"
    # Blog title
    global_title="My fancy blog"
    # The typical subtitle for each blog
    global_description="A blog about turtles and carrots"
    # The public base URL for this blog
    global_url="https://example.com/blog"
    # Your profile picture (default is emoji) (replace with valid URL to have your image show up on Webmentions)
    global_icon="data:image/png;base64,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"

    # Your name
    global_author="John Smith"
    # You can use twitter or facebook or anything for global_author_url
    global_author_url="https://twitter.com/example" 
    # Your email
    global_email="john@smith.com"

    # CC by-nc-nd is a good starting point, you can change this to "&copy;" for Copyright
    global_license="CC BY-NC-ND"

    # Webmentions
    # Ask for webmentions before posting. Default is true. Empty out to set to false
    global_wm_enabled="true"
    # your Webmention endpoint
    global_wm_endpoint="https://webmention.io/example.com/webmention"
    # Display received Webmentions on your pages. Default is true. Empty out to set to false
    global_display_wm="true"


    # If you have a Google Analytics ID (UA-XXXXX) and wish to use the standard
    # embedding code, put it on global_analytics
    # If you have custom analytics code (i.e. non-google) or want to use the Universal
    # code, leave global_analytics empty and specify a global_analytics_file
    global_analytics=""
    global_analytics_file=""

    # Leave this empty (i.e. "") if you don't want to use feedburner, 
    # or change it to your own URL
    global_feedburner=""

    # Change this to your username if you want to use twitter for comments
    global_twitter_username=""
    # Default image for the Twitter cards. Use an absolute URL
    global_twitter_card_image=""
    # Set this to false for a Twitter button with share count. The cookieless version
    # is just a link.
    global_twitter_cookieless="true"
    # Default search page, where tweets more than a week old are hidden
    global_twitter_search="twitter"

    # Change this to your disqus username to use disqus for comments
    global_disqus_username=""


    # Blog generated files
    # index page of blog (it is usually good to use "index.html" here)
    index_file="index.html"
    number_of_index_articles="20"
    # global archive
    archive_index="all_posts.html"
    tags_index="all_tags.html"

    # Non blogpost files. Bashblog will ignore these. Useful for static pages and custom content
    # Add them as a bash array, e.g. non_blogpost_files=("news.html" "test.html")
    non_blogpost_files=()

    # feed file (rss in this case)
    blog_feed="feed.rss"
    number_of_feed_articles="10"
    # "cut" blog entry when putting it to index page. Leave blank for full articles in front page
    # i.e. include only up to first '<hr>', or '----' in markdown
    cut_do="cut"
    # When cutting, cut also tags? If "no", tags will appear in index page for cut articles
    cut_tags="yes"
    # Regexp matching the HTML line where to do the cut
    # note that slash is regexp separator so you need to prepend it with backslash
    cut_line='<hr ?\/?>'
    # save markdown file when posting with "bb post -m". Leave blank to discard it.
    save_markdown="yes"
    # prefix for tags/categories files
    # please make sure that no other html file starts with this prefix
    prefix_tags="tag_"
    # personalized header and footer (only if you know what you're doing)
    # DO NOT name them .header.html, .footer.html or they will be overwritten
    # leave blank to generate them, recommended
    header_file=""
    footer_file=""
    # extra content to add just after we open the <body> tag
    # and before the actual blog content
    body_begin_file=""
    # extra content to add just before we close </body>
    body_end_file=""
    # extra content to ONLY on the index page AFTER `body_begin_file` contents
    # and before the actual content
    body_begin_file_index=""
    # CSS files to include on every page, f.ex. css_include=('main.css' 'blog.css')
    # leave empty to use generated
    css_include=()
    # HTML files to exclude from index, f.ex. post_exclude=('imprint.html 'aboutme.html')
    html_exclude=()

    # Localization and i18n
    # "Comments?" (used in twitter link after every post)
    template_comments="Comments?"
    # "Read more..." (link under cut article on index page)
    template_read_more="Read more..."
    # "View more posts" (used on bottom of index page as link to archive)
    template_archive="View more posts"
    # "All posts" (title of archive page)
    template_archive_title="All posts"
    # At the bottom of the index page
    template_archive_expand="View more&hellip;"
    # "All tags"
    template_tags_title="All tags"
    # "posts" (on "All tags" page, text at the end of each tag line, like "2. Music - 15 posts")
    template_tags_posts="posts"
    template_tags_posts_2_4="posts"  # Some slavic languages use a different plural form for 2-4 items
    template_tags_posts_singular="post"
    # "Posts tagged" (text on a title of a page with index of one tag, like "My Blog - Posts tagged "Music"")
    template_tag_title="Posts tagged"
    # "Tags:" (beginning of line in HTML file with list of all tags for this article)
    template_tags_line_header="Tags:"
    # "Back to the index page" (used on archive page, it is link to blog index)
    template_archive_index_page="Home"
    # "Subscribe" (used on bottom of index page, it is link to RSS feed)
    template_subscribe="Subscribe"
    # "Subscribe to this page..." (used as text for browser feed button that is embedded to html)
    template_subscribe_browser_button="Subscribe to this page..."
    # "Tweet" (used as twitter text button for posting to twitter)
    template_twitter_button="Tweet"
    template_twitter_comment="&lt;Type your comment here but please leave the URL so that other people can follow the comments&gt;"
    
    # The locale to use for the dates displayed on screen
    date_format="%B %d, %Y"
    date_locale="C"
    date_inpost="bashblog_timestamp"
    # Don't change these dates
    date_format_full="%a, %d %b %Y %H:%M:%S %z"
    date_format_timestamp="%Y%m%d%H%M.%S"
    date_allposts_header="%B %Y"

    # Perform the post title -> filename conversion
    # Experts only. You may need to tune the locales too
    # Leave empty for no conversion, which is not recommended
    # This default filter respects backwards compatibility
    convert_filename="iconv -f utf-8 -t ascii//translit | sed 's/^-*//' | tr [:upper:] [:lower:] | tr ' ' '-' | tr -dc '[:alnum:]-'"

    # URL where you can view the post while it's being edited
    # same as global_url by default
    # You can change it to path on your computer, if you write posts locally
    # before copying them to the server
    preview_url=""

    # Markdown location. Trying to autodetect by default.
    # The invocation must support the signature 'markdown_bin in.md > out.html'
    [[ -f Markdown.pl ]] && markdown_bin=./Markdown.pl || markdown_bin=$(which Markdown.pl 2>/dev/null || which markdown 2>/dev/null)
}

    # Javascript for displaying webmentions on the page
webmention_js="webmention.js"
    if [[ -z $global_display_wm ]] && [[ $(ls webmention.js 2>/dev/null) = "" ]]; then
    wget -O $webmention_js "https://raw.githubusercontent.com/PlaidWeb/webmention.js/refs/heads/main/static/webmention.js"
    fi
 
   
# Check for the validity of some variables
# DO NOT EDIT THIS FUNCTION unless you know what you're doing
global_variables_check() {
    [[ $header_file == .header.html ]] &&
        echo "Please check your configuration. '.header.html' is not a valid value for the setting 'header_file'" &&
        exit
    [[ $footer_file == .footer.html ]] &&
        echo "Please check your configuration. '.footer.html' is not a valid value for the setting 'footer_file'" &&
        exit
}


# Test if the markdown script is working correctly
test_markdown() {
    [[ -n $markdown_bin ]] &&
        (
        [[ $("$markdown_bin" <<< $'line 1\n\nline 2') == $'<p>line 1</p>\n\n<p>line 2</p>' ]] ||
        [[ $("$markdown_bin" <<< $'line 1\n\nline 2') == $'<p>line 1</p>\n<p>line 2</p>' ]]
        )
}


# Parse a Markdown file into HTML and return the generated file
markdown() {
    out=${1%.md}.html
    while [[ -f $out ]]; do out=${out%.html}.$RANDOM.html; done
    $markdown_bin "$1" > "$out"
    echo "$out"
}


# Prints the required google analytics code
google_analytics() {
    [[ -z $global_analytics && -z $global_analytics_file ]]  && return

    if [[ -z $global_analytics_file ]]; then
        echo "<script type=\"text/javascript\">

        var _gaq = _gaq || [];
        _gaq.push(['_setAccount', '${global_analytics}']);
        _gaq.push(['_trackPageview']);

        (function() {
        var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
        ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
        var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
        })();

        </script>"
    else
        cat "$global_analytics_file"
    fi
}

# Prints the required code for disqus comments
disqus_body() {
    [[ -z $global_disqus_username ]] && return

    echo '<div id="disqus_thread"></div>
            <script type="text/javascript">
            /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
               var disqus_shortname = '"'$global_disqus_username'"'; // required: replace example with your forum shortname

            /* * * DONT EDIT BELOW THIS LINE * * */
            (function() {
            var dsq = document.createElement("script"); dsq.type = "text/javascript"; dsq.async = true;
            dsq.src = "//" + disqus_shortname + ".disqus.com/embed.js";
            (document.getElementsByTagName("head")[0] || document.getElementsByTagName("body")[0]).appendChild(dsq);
            })();
            </script>
            <noscript>Please enable JavaScript to view the <a href="http://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
            <a href="http://disqus.com" class="dsq-brlink">comments powered by <span class="logo-disqus">Disqus</span></a>'
}

# Prints the required code for disqus in the footer
disqus_footer() {
    [[ -z $global_disqus_username ]] && return
    echo '<script type="text/javascript">
        /* * * CONFIGURATION VARIABLES: EDIT BEFORE PASTING INTO YOUR WEBPAGE * * */
        var disqus_shortname = '"'$global_disqus_username'"'; // required: replace example with your forum shortname

        /* * * DONT EDIT BELOW THIS LINE * * */
        (function () {
        var s = document.createElement("script"); s.async = true;
        s.type = "text/javascript";
        s.src = "//" + disqus_shortname + ".disqus.com/count.js";
        (document.getElementsByTagName("HEAD")[0] || document.getElementsByTagName("BODY")[0]).appendChild(s);
    }());
    </script>'
}


# Reads HTML file from stdin, prints its content to stdout
# $1    where to start ("text" or "entry")
# $2    where to stop ("text" or "entry")
# $3    "cut" to remove text from <hr /> to <!-- text end -->
#       note that this does not remove <hr /> line itself,
#       so you can see if text was cut or not
get_html_file_content() {
    awk "/<!-- $1 begin -->/, /<!-- $2 end -->/{
        if (!/<!-- $1 begin -->/ && !/<!-- $2 end -->/) print
        if (\"$3\" == \"cut\" && /$cut_line/){
            if (\"$2\" == \"text\") exit # no need to read further
            while (getline > 0 && !/<!-- text end -->/) {
                if (\"$cut_tags\" == \"no\" && /^<p>$template_tags_line_header/ ) print 
            }
        }
    }"
}

# Edit an existing, published .html file while keeping its original timestamp
# Please note that this function does not automatically republish anything, as
# it is usually called from 'main'.
#
# Note that it edits HTML file, even if you wrote the post as markdown originally
# Note that if you edit title then filename might also change
#
# $1 	the file to edit
# $2	(optional) edit mode:
#	"keep" to keep old filename
#	"full" to edit full HTML, and not only text part (keeps old filename)
#	leave empty for default behavior (edit only text part and change name)
edit() {
    [[ ! -f "${1%%.*}.html" ]] && echo "Can't edit post "${1%%.*}.html", did you mean to use \"bb.sh post <draft_file>\"?" && exit -1
    # Original post timestamp
    edit_timestamp=$(LC_ALL=C date -r "${1%%.*}.html" +"$date_format_full" )
    touch_timestamp=$(LC_ALL=C date -r "${1%%.*}.html" +"$date_format_timestamp")
    tags_before=$(tags_in_post "${1%%.*}.html")
    if [[ $2 == full ]]; then
        $EDITOR "$1"
        filename=$1
    else
        if [[ ${1##*.} == md ]]; then
            test_markdown
            if (($? != 0)); then
                echo "Markdown is not working, please edit HTML file directly."
                exit
            fi
            # editing markdown file
            $EDITOR "$1"
            TMPFILE=$(markdown "$1")
            filename=${1%%.*}.html
        else
            # Create the content file
            TMPFILE=$(basename "$1").$RANDOM.html
            # Title
            get_post_title "$1" > "$TMPFILE"
            # Post text with plaintext tags
            $EDITOR "$TMPFILE"
            filename=$1
        fi
        rm "$filename"
        if [[ $2 == keep ]]; then
            parse_file "$TMPFILE" "$edit_timestamp" "$filename"
        else
            parse_file "$TMPFILE" "$edit_timestamp" # this command sets $filename as the html processed file
            [[ ${1##*.} == md ]] && mv "$1" "${filename%%.*}.md" 2>/dev/null
        fi
        rm "$TMPFILE"
    fi
    touch -t "$touch_timestamp" "$filename"
    touch -t "$touch_timestamp" "$1"
    chmod 644 "$filename"
    echo "Posted $filename"
    tags_after=$(tags_in_post "$filename")
    relevant_tags=$(echo "$tags_before $tags_after" | tr ',' ' ' | tr ' ' '\n' | sort -u | tr '\n' ' ')
    if [[ ! -z $relevant_tags ]]; then
        relevant_posts="$(posts_with_tags $relevant_tags) $filename"
        rebuild_tags "$relevant_posts" "$relevant_tags"
    fi
}

# Create a Twitter summary (twitter "card") for the post
#
# $1 the post file
# $2 the title
twitter_card() {
    [[ -z $global_twitter_username ]] && return
    
    echo "<meta name='twitter:card' content='summary' >"
    echo "<meta name='twitter:site' content='@$global_twitter_username' >"
    echo "<meta name='twitter:title' content='$2' >" # Twitter truncates at 70 char
    description=$(grep -v "^<p>$template_tags_line_header" "$1" | sed -e 's/<[^>]*>//g' | tr '\n' ' ' | sed "s/\"/'/g" | head -c 250) 
    echo "<meta name='twitter:description' content=\"$description\" >"

    # For the image we try to locate the first image in the article
    image=$(sed -n '2,$ d; s/.*<img.*src="\([^"]*\)".*/\1/p' "$1") 

    # If none, then we try a global setting image
    [[ -z $image ]] && [[ -n $global_twitter_card_image ]] && image=$global_twitter_card_image

    # If none, return
    [[ -z $image ]] && return

    # Final housekeeping
    [[ $image =~ ^https?:// ]] || image=$global_url/$image # Check that URL is absolute
    echo "<meta name='twitter:image' content='$image' >"
}

# Adds the code needed by the twitter button
#
# $1 the post URL
twitter() {
    [[ -z $global_twitter_username ]] && return

    if [[ -z $global_disqus_username ]]; then
        if [[ $global_twitter_cookieless == true ]]; then 
            id=$RANDOM

            search_engine="https://twitter.com/search?q="

            echo "<p id='twitter'><a href='http://twitter.com/intent/tweet?url=$1&text=$template_twitter_comment&via=$global_twitter_username'>$template_comments $template_twitter_button</a> "
            echo "<a href='$search_engine""$1'><span id='count-$id'></span></a>&nbsp;</p>"
            return;
        else 
            echo "<p id='twitter'>$template_comments&nbsp;"; 
        fi
    else
        echo "<p id='twitter'><a href=\"$1#disqus_thread\">$template_comments</a> &nbsp;"
    fi  

    echo "<a href=\"https://twitter.com/share\" class=\"twitter-share-button\" data-text=\"$template_twitter_comment\" data-url=\"$1\""
    echo " data-via=\"$global_twitter_username\""
    echo ">$template_twitter_button</a>	<script>!function(d,s,id){var js,fjs=d.getElementsByTagName(s)[0];if(!d.getElementById(id)){js=d.createElement(s);js.id=id;js.src=\"//platform.twitter.comwidgets.js\";fjs.parentNode.insertBefore(js,fjs);}}(document,\"script\",\"twitter-wjs\");</script>"
    echo "</p>"
}

# Check if the file is a 'boilerplate' (i.e. not a post)
# The return values are designed to be used like this inside a loop:
# is_boilerplate_file <file> && continue
#
# $1 the file
#
# Return 0 (bash return value 'true') if the input file is an index, feed, etc
# or 1 (bash return value 'false') if it is a blogpost
is_boilerplate_file() {
    name=${1#./}
    # First check against user-defined non-blogpost pages
    for item in "${non_blogpost_files[@]}"; do
        [[ "$name" == "$item" ]] && return 0
    done

    case $name in
    ( "$index_file" | "$archive_index" | "$tags_index" | "$footer_file" | "$header_file" | "$global_analytics_file" | "$prefix_tags"* )
        return 0 ;;
    ( * ) # Check for excluded
        for excl in "${html_exclude[@]}"; do
            [[ $name == "$excl" ]] && return 0
        done
        return 1 ;;
    esac
}

# Adds all the bells and whistles to format the html page
# Every blog post is marked with a <!-- entry begin --> and <!-- entry end -->
# which is parsed afterwards in the other functions. There is also a marker
# <!-- text begin --> to determine just the beginning of the text body of the post
#
# $1     a file with the body of the content
# $2     the output file
# $3     "yes" if we want to generate the index.html,
#        "no" to insert new blog posts
# $4     title for the html header
# $5     original blog timestamp
# $6     post author
create_html_page() {
    content=$1
    filename=$2
    index=$3
    title=$4
    timestamp=$5
    author=$6

    # Create the actual blog post
    # html, head
    {
        cat ".header.html"
        echo "<title>$title</title>"
        google_analytics
        twitter_card "$content" "$title"
        echo "</head><body>"
        # stuff to add before the actual body content
        [[ -n $body_begin_file ]] && cat "$body_begin_file"
        [[ $filename = $index_file* ]] && [[ -n $body_begin_file_index ]] && cat "$body_begin_file_index"
        # body 
        echo '<header>'
        # blog title
        cat .title.html
        echo '</header>' # header
        echo '<main>'
        file_url=${filename#./}
        file_url=${file_url%.rebuilt} # Get the correct URL when rebuilding
        # one blog entry
        if [[ $index == no ]]; then
            echo '<!-- entry begin -->' # marks the beginning of the whole post
            echo '<article class=h-entry>'
            echo "<h2><a class=\"p-name\" href=\"$file_url\">"
            # remove possible <p>'s on the title because of markdown conversion
            title=${title//<p>/}
            title=${title//<\/p>/}
            echo "$title"
            echo '</a></h2>'
            if [[ -z $timestamp ]]; then
                echo "<!-- $date_inpost: #$(LC_ALL=$date_locale date +"$date_format_timestamp")# -->"
            else
                echo "<!-- $date_inpost: #$(LC_ALL=$date_locale date +"$date_format_timestamp" --date="$timestamp")# -->"
            fi
            if [[ -z $timestamp ]]; then
                echo -n "<p class=\"subtitle\"><time class='dt-published' datetime=$(date '+%Y-%m-%d')>$(LC_ALL=$date_locale date +"$date_format")</time>"
            else
                echo -n "<p class=\"subtitle\"><time class='dt-published' datetime=$(date '+%Y-%m-%d')>$(LC_ALL=$date_locale date +"$date_format" --date="$timestamp")</time>"
            fi
            [[ -n $author ]] && echo -e " &mdash; <span class=\"p-author h-card\"><a href=\"$global_url\" class=\"u-url\"><img aria-hidden=true src=$global_icon alt=\"\" class=\"u-photo\"></a>$global_author</span> ($global_license)"
            echo "</p>"
            echo '<!-- text begin -->' # This marks the text body, after the title, date...
        fi
        cat "$content" # Actual content
        if [[ $index == no ]]; then
            echo -e '<!-- text end -->'

            twitter "$global_url/$file_url"
            echo '</article>'
            echo '<!-- entry end -->' # absolute end of the post
        fi
        if [[ -n $global_display_wm ]]; then
           echo '<div sort-by=type id="webmentions"></div>' # display Webmentions
        fi
        # Add disqus commments except for index and all_posts pages
        [[ $index == no ]] && disqus_body
        echo "</main>"
        # page footer
        cat .footer.html
        # close divs
#        echo '</div></div>' # divbody and divbodyholder 
        disqus_footer
        [[ -n $body_end_file ]] && cat "$body_end_file"
        echo '</body></html>'
    } > "$filename"
}

# Parse the plain text file into an html file
#
# $1    source file name
# $2    (optional) timestamp for the file
# $3    (optional) destination file name
# note that although timestamp is optional, something must be provided at its
# place if destination file name is provided, i.e:
# parse_file source.txt "" destination.html
parse_file() {
    # Read for the title and check that the filename is ok
    title=""
    while IFS='' read -r line; do
        if [[ -z $title ]]; then
            # remove extra <p> and </p> added by markdown
            title=$(echo "$line" | sed 's/<\/*p>//g')
            if [[ -n $3 ]]; then
                filename=$3
            else
                filename=$title
                [[ -n $convert_filename ]] &&
                    filename=$(echo "$title" | eval "$convert_filename")
                [[ -n $filename ]] || 
                    filename=$RANDOM # don't allow empty filenames

                filename=$filename.html

                # Check for duplicate file names
                while [[ -f $filename ]]; do
                    filename=${filename%.html}$RANDOM.html
                done
            fi
            content=$filename.tmp

       # Parse possible tags
        elif [[ $line == "<p>$template_tags_line_header"* ]]; then
            tags=$(echo "$line" | cut -d ":" -f 2- | sed -e 's/<\/p>//g' -e 's/^ *//' -e 's/ *$//' -e 's/, /,/g')
            IFS=, read -r -a array <<< "$tags"

            echo -n "<p>$template_tags_line_header " >> "$content"
            for item in "${array[@]}"; do
                echo -n "<a href='$prefix_tags$item.html'>$item</a>, "
            done | sed 's/, $/<\/p>/g' >> "$content"
        else
            echo "$line" >> "$content"
        fi

    done < "$1"

    # Create the actual html page
    create_html_page "$content" "$filename" no "$title" "$2" "$global_author"
    rm "$content"
}

# Manages the creation of the text file and the parsing to html file
# also the drafts

write_entry() {
    test_markdown && fmt=md || fmt=html
    f=$2
    [[ $2 == -html ]] && fmt=html && f=$3

    if [[ -n $f ]]; then
        TMPFILE=$f
        if [[ ! -f $TMPFILE ]]; then
            echo "The file doesn't exist"
            delete_includes
            exit
        fi
        # guess format from TMPFILE
        extension=${TMPFILE##*.}
        [[ $extension == md || $extension == html ]] && fmt=$extension
        # but let user override it (`bb.sh post -html file.md`)
        [[ $2 == -html ]] && fmt=html
        # Test if Markdown is working before re-posting a .md file
        if [[ $extension == md ]]; then
            test_markdown
            if (($? != 0)); then
                echo "Markdown is not working, please edit HTML file directly."
                exit
            fi
        fi
    else
        TMPFILE=.entry-$RANDOM.$fmt
        echo -e "Title on this line\n" >> "$TMPFILE"
  # ask for webmentions
if [[ -n $global_wm_enabled ]]; then
        echo -n "Do you want to send a webmention? y/N
"
        read -r wm_value
            if [[ $wm_value == y* || $wm_value == Y* ]]; then
            wm_tags="webmention, "
            echo '(L)ike/(Re)ply/(B)ookmark/(Rs)vp?' 
            read -r wm_type
            echo "URL:"
            read -r wm_URL
                if [[ $wm_URL = "" ]]; then
                echo "Not a URL. Nothing"
                else
                echo 'Message:' 
                read  wm_message
                    if [[ $wm_type == l* || $wm_type == L* ]]; then
                    wm_type_full='like'
                    wm_text="Like"
                    wm_prepostion='of'
                    wm_extra='u'
                    elif [[ $wm_type == rs* || $wm_type == RS* || $wm_type == Rs* ]]; then
                    rsvp="true"
                    echo "Are you going (yes/no/maybe)"
                    wm_type_full='reply'
                    wm_text="Reply"
                    wm_prepostion='to'
                    wm_extra='u-in'
                    read -r rsvp_value
                    elif [[ $wm_type == re* || $wm_type == RE* || $wm_type == Re* ]]; then
                    wm_type_full='reply'
                    wm_text="Reply"
                    wm_prepostion='to'
                    wm_extra='u-in'
                    elif [[ $wm_type == b* || $wm_type == B* ]]; then
                    wm_type_full='bookmark'
                    wm_text="Bookmark"
                    wm_prepostion='of'
                    wm_extra='u'
                    else
                    echo "Webmention type not recognized."
                    fi
             
                fi
# Put Webmention code into line 2 before opening the editor
        wm_formatted_type="$wm_extra-$wm_type_full-$wm_prepostion"
        wm_url_title="$(curl -s $wm_URL |  perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si' |  sed 's/|/\\|/g' | sed 's/\&/\\&/g')" 
        if [[ $rsvp == "true" ]]; then
           echo "<p class=\"rsvp\">RSVP <data class='p-rsvp' value='$rsvp_value'>$rsvp_value</data> to <a class=\"$wm_formatted_type\" href=\"$(echo $wm_URL  | sed 's/\&/\\&/g')\"> $wm_url_title </a> <p class=e-content>$(echo $wm_message | sed 's/|/\\|/g' | sed 's/\&/\\&/g')</p>" >> "$TMPFILE"
        else
        echo "<p class=\"$wm_type_full\">$wm_text $wm_prepostion <a class=\"$wm_formatted_type\" href=\"$(echo $wm_URL  | sed 's/\&/\\&/g')\">$wm_url_title</a> <p class=e-content>$(echo $wm_message | sed 's/|/\\|/g' | sed 's/\&/\\&/g')</p>" >> "$TMPFILE"
        fi

        else
        wm_tags="keep-this-tag-format, tags-are-optional, beware-with-underscores-in-markdown, example"
        echo -n "Okay :^)" # no webmention? no problem
        fi
fi

        [[ $fmt == html ]] && cat << EOF >> "$TMPFILE"

<p>The rest of the text file is an <b>html</b> blog post. The process will continue as soon
as you exit your editor.</p>

<p>$template_tags_line_header $wm_tags$wm_type_full</p>

<❤️>

EOF
        [[ $fmt == md ]] && cat << EOF >> "$TMPFILE"

The rest of the text file is a **Markdown** blog post. The process will continue
as soon as you exit your editor.

$template_tags_line_header $wm_tags$wm_type_full

<❤️> 
EOF
    fi
    chmod 600 "$TMPFILE"

    post_status="E"
    filename=""




    while [[ $post_status != "p" && $post_status != "P" ]]; do
        [[ -n $filename ]] && rm "$filename" # Delete the generated html file, if any
        $EDITOR "$TMPFILE"
        if [[ $fmt == md ]]; then
            html_from_md=$(markdown "$TMPFILE")
            parse_file "$html_from_md"
            rm "$html_from_md"
        else

            parse_file "$TMPFILE" # this command sets $filename as the html processed file


        fi
        
        chmod 644 "$filename"
        [[ -n $preview_url ]] || preview_url=$global_url
        echo "To preview the entry, open $preview_url/$filename in your browser"

        echo -n "[P]ost this entry, [E]dit again, [D]raft for later? (p/E/d) "
        read -r post_status


        if [[ $post_status == d || $post_status == D ]]; then
            mkdir -p "drafts/"
            chmod 700 "drafts/"

            title=$(head -n 1 $TMPFILE)
            [[ -n $convert_filename ]] && title=$(echo "$title" | eval "$convert_filename")
            [[ -n $title ]] || title=$RANDOM

            draft=drafts/$title.$fmt
            mv "$TMPFILE" "$draft"
            chmod 600 "$draft"
            rm "$filename"
            delete_includes
            echo "Saved your draft as '$draft'"
            exit
        fi
    done

      
    if [[ $fmt == md && -n $save_markdown ]]; then
        mv "$TMPFILE" "${filename%%.*}.md"
    else
        rm "$TMPFILE"
    fi
    # replace symbol with open heart protocol https://openheart.fyi/
    sed -i "s|&lt;❤️>|<open-heart href=\"https://corazon.sploot.com?id=$global_url/$filename\" emoji=\"❤️\">❤️</open-heart><!-- load webcomponent --><script src=\"https://unpkg.com/open-heart-element\" type=\"module\"></script><!-- when the webcomponent loads, fetch the current counts for that page --><script>window.customElements.whenDefined('open-heart').then(() => { for (const oh of document.querySelectorAll('open-heart')) { oh.getCount() } })\n// refresh component after click\nwindow.addEventListener('open-heart', e => { e && e.target && e.target.getCount && e.target.getCount() })</script>|" $filename
    chmod 644 "$filename"
    echo "Posted $filename"
if [[ $wm_value == y* || $wm_value == Y* ]]; then
wm_sender="curl -si $(echo $(curl -si $wm_URL | grep 'rel=\"webmention\"') | grep -o -m 1 'https://.*' | sed 's/">//g') \
  -d source=$global_url/$filename \
  -d target=$wm_URL"

echo -e "\n\nPreparing to send webmention:\n    $wm_sender\n\nDoes this look OK? (y/N)"
read ok
if [[ $ok == y* ]]; then
$wm_sender
else
echo "What is the webmention endpoint?"
read wm_endpoint
curl -si $wm_endpoint \
  -d source=$global_url/$filename \
  -d target=$wm_URL
fi
fi
    relevant_tags=$(tags_in_post $filename)
    if [[ -n $relevant_tags ]]; then
        relevant_posts="$(posts_with_tags $relevant_tags) $filename"
        rebuild_tags "$relevant_posts" "$relevant_tags"
    fi
}

# Create an index page with all the posts
all_posts() {
    echo -n "Creating an index page with all the posts "
    contentfile=$archive_index.$RANDOM
    while [[ -f $contentfile ]]; do
        contentfile=$archive_index.$RANDOM
    done

    {
        echo "<h2>$template_archive_title</h2>"
        prev_month=""
        while IFS='' read -r i; do
            is_boilerplate_file "$i" && continue
            echo -n "." 1>&3
            # Month headers
            month=$(LC_ALL=$date_locale date -r "$i" +"$date_allposts_header")
            if [[ $month != "$prev_month" ]]; then
                [[ -n $prev_month ]] && echo "</ul>"  # Don't close ul before first header
                echo "<h3 class='allposts_header'>$month</h3>"
                echo "<ul>"
                prev_month=$month
            fi
            # Title
            title=$(get_post_title "$i")
            echo -n "<li><a href=\"$i\">$title</a> &mdash;"
            # Date
            date=$(LC_ALL=$date_locale date -r "$i" +"$date_format")
            echo " $date</li>"
        done < <(ls -t ./*.html)
        echo "" 1>&3
        echo "</ul>"
 
    } 3>&1 >"$contentfile"

    create_html_page "$contentfile" "$archive_index.tmp" yes "$global_title &mdash; $template_archive_title" "$global_author"
    mv "$archive_index.tmp" "$archive_index"
    chmod 644 "$archive_index"
    rm "$contentfile"
}

# Create an index page with all the tags
all_tags() {
    echo -n "Creating an index page with all the tags "
    contentfile=$tags_index.$RANDOM
    while [[ -f $contentfile ]]; do
        contentfile=$tags_index.$RANDOM
    done

    {
        echo "<h2>$template_tags_title</h2>"
        echo "<ul>"
        for i in $prefix_tags*.html; do
            [[ -f "$i" ]] || break
            echo -n "." 1>&3
            nposts=$(grep -c "<\!-- text begin -->" "$i")
            tagname=${i#"$prefix_tags"}
            tagname=${tagname%.html}
            case $nposts in
                1) word=$template_tags_posts_singular;;
                2|3|4) word=$template_tags_posts_2_4;;
                *) word=$template_tags_posts;;
            esac
            echo "<li><a href=\"$i\">$tagname</a> &mdash; $nposts $word</li>"
        done
        echo "" 1>&3
        echo "</ul>"
  
    } 3>&1 > "$contentfile"

    create_html_page "$contentfile" "$tags_index.tmp" yes "$global_title &mdash; $template_tags_title" "$global_author"
    mv "$tags_index.tmp" "$tags_index"
    chmod 644 "$tags_index"
    rm "$contentfile"
}

# Generate the index.html with the content of the latest posts
rebuild_index() {
    echo -n "Rebuilding the index "
    newindexfile=$index_file.$RANDOM
    contentfile=$newindexfile.content
    while [[ -f $newindexfile ]]; do 
        newindexfile=$index_file.$RANDOM
        contentfile=$newindexfile.content
    done

    # Create the content file

    {
        n=0
echo "<div class=\"h-feed\">"
        while IFS='' read -r i; do
            is_boilerplate_file "$i" && continue;
            if ((n >= number_of_index_articles)); then break; fi
            if [[ -n $cut_do ]]; then
                get_html_file_content 'entry' 'entry' 'cut' <"$i" | awk "/$cut_line/ { print \"<p class=\\\"readmore\\\"><a href=\\\"$i\\\">$template_read_more</a></p>\" ; next } 1"
            else
                get_html_file_content 'entry' 'entry' <"$i"
            fi
            echo -n "." 1>&3
            n=$(( n + 1 ))
        done < <(ls -t ./*.html) # sort by date, newest first
echo "<nav><a href=\"$archive_index\">$template_archive_expand</a></nav></div>"
        feed=$blog_feed
        if [[ -n $global_feedburner ]]; then feed=$global_feedburner; fi

    } 3>&1 >"$contentfile"

    echo ""

    create_html_page "$contentfile" "$newindexfile" yes "$global_title" "$global_author"
    rm "$contentfile"
    mv "$newindexfile" "$index_file"
    chmod 644 "$index_file"
}

# Finds all tags referenced in one post.
# Accepts either filename as first argument, or post content at stdin
# Prints one line with space-separated tags to stdout
tags_in_post() {
    sed -n "/^<p>$template_tags_line_header/{s/^<p>$template_tags_line_header//;s/<[^>]*>//g;s/[ ,]\+/ /g;p;}" "$1" | tr ', ' ' '
}

# Finds all posts referenced in a number of tags.
# Arguments are tags
# Prints one line with space-separated tags to stdout
posts_with_tags() {
    (($# < 1)) && return
    set -- "${@/#/$prefix_tags}"
    set -- "${@/%/.html}"
    sed -n '/^<h2><a class="p-name" href="[^"]*">/{s/.*href="\([^"]*\)">.*/\1/;p;}' "$@" 2> /dev/null
}

# Rebuilds tag_*.html files
# if no arguments given, rebuilds all of them
# if arguments given, they should have this format:
# "FILE1 [FILE2 [...]]" "TAG1 [TAG2 [...]]"
# where FILEn are files with posts which should be used for rebuilding tags,
# and TAGn are names of tags which should be rebuilt.
# example:
# rebuild_tags "one_post.html another_article.html" "example-tag another-tag"
# mind the quotes!
rebuild_tags() {
    if (($# < 2)); then
        # will process all files and tags
        files=$(ls -t ./*.html)
        all_tags=yes
    else
        # will process only given files and tags
        files=$(printf '%s\n' $1 | sort -u)
        files=$(ls -t $files)
        tags=$2
    fi
    echo -n "Rebuilding tag pages "
    n=0
    if [[ -n $all_tags ]]; then
        rm ./"$prefix_tags"*.html &> /dev/null
    else
        for i in $tags; do
            rm "./$prefix_tags$i.html" &> /dev/null
        done
    fi
    # First we will process all files and create temporal tag files
    # with just the content of the posts
    tmpfile=tmp.$RANDOM
    while [[ -f $tmpfile ]]; do tmpfile=tmp.$RANDOM; done
    while IFS='' read -r i; do
        is_boilerplate_file "$i" && continue;
        echo -n "."
        if [[ -n $cut_do ]]; then
            get_html_file_content 'entry' 'entry' 'cut' <"$i" | awk "/$cut_line/ { print \"<p class=\\\"readmore\\\"><a href=\\\"$i\\\">$template_read_more</a></p>\" ; next } 1"
        else
            get_html_file_content 'entry' 'entry' <"$i"
        fi >"$tmpfile"
        for tag in $(tags_in_post "$i"); do
            if [[ -n $all_tags || " $tags " == *" $tag "* ]]; then
                cat "$tmpfile" >> "$prefix_tags$tag".tmp.html
            fi
        done
    done <<< "$files"
    rm "$tmpfile"
    # Now generate the tag files with headers, footers, etc
    while IFS='' read -r i; do
        tagname=${i#./"$prefix_tags"}
        tagname=${tagname%.tmp.html}
        create_html_page "$i" "$prefix_tags$tagname.html" yes "$global_title &mdash; $template_tag_title \"$tagname\"" "$global_author"
        rm "$i"
    done < <(ls -t ./"$prefix_tags"*.tmp.html 2>/dev/null)
    echo
}

# Return the post title
#
# $1 the html file
get_post_title() {
    awk '/<h2><a class="p-name" href=".+">/, /<\/a><\/h2>/{if (!/<h2><a class="p-name" href=".+">/ && !/<\/a><\/h2>/) print}' "$1"
}

# Return the post author
#
# $1 the html file
get_post_author() { 
    awk '/<time .+/, /<!-- text begin -->/{if (!/<time. +/ && !/<!-- text begin -->/) print}' "$1" | sed 's/<\/time>//g'
}

# Displays a list of the tags
#
# $2 if "-n", tags will be sorted by number of posts
list_tags() {
    if [[ $2 == -n ]]; then do_sort=1; else do_sort=0; fi

    ls ./$prefix_tags*.html &> /dev/null
    (($? != 0)) && echo "No posts yet. Use 'bb.sh post' to create one" && return

    lines=""
    for i in $prefix_tags*.html; do
        [[ -f "$i" ]] || break
        nposts=$(grep -c "<\!-- text begin -->" "$i")
        tagname=${i#"$prefix_tags"}
        tagname=${tagname#.html}
        ((nposts > 1)) && word=$template_tags_posts || word=$template_tags_posts_singular
        line="$tagname # $nposts # $word"
        lines+=$line\\n
    done

    if (( do_sort == 1 )); then
        echo -e "$lines" | column -t -s "#" | sort -nrk 2
    else
        echo -e "$lines" | column -t -s "#" 
    fi
}

# Displays a list of the posts
list_posts() {
    ls ./*.html &> /dev/null
    (($? != 0)) && echo "No posts yet. Use 'bb.sh post' to create one" && return

    lines=""
    n=1
    while IFS='' read -r i; do
        is_boilerplate_file "$i" && continue
        line="$n # $(get_post_title "$i") # $(LC_ALL=$date_locale date -r "$i" +"$date_format")"
        lines+=$line\\n
        n=$(( n + 1 ))
    done < <(ls -t ./*.html)

    echo -e "$lines" | column -t -s "#"
}

# Generate the feed file
make_rss() {
    echo -n "Making RSS "

    rssfile=$blog_feed.$RANDOM
    while [[ -f $rssfile ]]; do rssfile=$blog_feed.$RANDOM; done

    {
        pubdate=$(LC_ALL=C date +"$date_format_full")
        echo '<?xml version="1.0" encoding="UTF-8" ?>' 
        echo '<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:dc="http://purl.org/dc/elements/1.1/">' 
        echo "<channel><title>$global_title</title><link>$global_url/$index_file</link>"
        echo "<description>$global_description</description><language>en</language>"
        echo "<lastBuildDate>$pubdate</lastBuildDate>"
        echo "<pubDate>$pubdate</pubDate>"
        echo "<atom:link href=\"$global_url/$blog_feed\" rel=\"self\" type=\"application/rss+xml\" />"
    
        n=0
        while IFS='' read -r i; do
            is_boilerplate_file "$i" && continue
            ((n >= number_of_feed_articles)) && break # max 10 items
            echo -n "." 1>&3
            echo '<item><title>' 
            get_post_title "$i"
            echo '</title><description><![CDATA[' 
            get_html_file_content 'text' 'entry' $cut_do <"$i"
            echo "]]></description><link>$global_url/${i#./}</link>" 
            echo "<guid>$global_url/$i</guid>" 
            echo "<dc:creator>$(get_post_author "$i")</dc:creator>" 
            echo "<pubDate>$(LC_ALL=C date -r "$i" +"$date_format_full")</pubDate></item>"
    
            n=$(( n + 1 ))
        done < <(ls -t ./*.html)
    
        echo '</channel></rss>'
    } 3>&1 >"$rssfile"
    echo ""

    mv "$rssfile" "$blog_feed"
    chmod 644 "$blog_feed"
}

# generate headers, footers, etc
create_includes() {
    {
        echo "<h1 class=\"nomargin\"><a class=\"p-name\" href=\"$global_url/$index_file\">$global_title</a></h1>" 
        echo "<nav><p><a href=\"$global_url\">$template_archive_index_page</a> <a href=\"$archive_index\">$template_archive_title</a>  <a href=\"$tags_index\">$template_tags_title</a> </p></nav>"
   echo "<div id=\"description\">$global_description</div>"   
 } > ".title.html"

    if [[ -f $header_file ]]; then cp "$header_file" .header.html
    else {
        echo '<!DOCTYPE html>'
        echo "<html lang='$global_lang'><head>"
        echo '<meta http-equiv="Content-type" content="text/html;charset=UTF-8">'
        echo '<meta name="viewport" content="width=device-width, initial-scale=1.0">'
        echo "<link rel=\"icon\" sizes=\"21x21\" href=\"$global_icon\">"
        echo "<link rel=\"webmention\" href=\"$global_wm_endpoint\">"
        if [[ -n $global_display_wm ]]; then
            echo "<script src=\"$webmention_js\" async></script>"
        fi
        printf '<link rel="stylesheet" href="%s" type="text/css">\n' "${css_include[@]}"
        if [[ -z $global_feedburner ]]; then
            echo "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"$template_subscribe_browser_button\" href=\"$blog_feed\">"
        else 
            echo "<link rel=\"alternate\" type=\"application/rss+xml\" title=\"$template_subscribe_browser_button\" href=\"$global_feedburner\">"
        fi
        } > ".header.html"
    fi

    if [[ -f $footer_file ]]; then cp "$footer_file" .footer.html
    else {
#        protected_mail=${global_email//@/&#64;}
#        protected_mail=${protected_mail//./&#46;}
        echo "<footer>Subscribe via <a href="$blog_feed">rss</a>!<br>Contact me via <a rel=\"me\" href=\"mailto:$global_email\">$global_email</a><br>"
        echo '<p><small>Generated using <a href="https://github.com/muscadomestica/indieweb-bashblog" target="_blank">indieweb-bashblog</a>, a single bash script to easily create blogs like this one &mdash; with Webmention and Microformats support</small></p></footer>'
        } >> ".footer.html"
    fi
}

# Delete the temporarily generated include files
delete_includes() {
    rm ".title.html" ".footer.html" ".header.html"
}

# Create the css file from scratch
create_css() {
    # To avoid overwriting manual changes. However it is recommended that
    # this function is modified if the user changes the blog.css file
    (( ${#css_include[@]} > 0 )) && return || css_include=('main.css' 'blog.css')
    if [[ ! -f blog.css ]]; then 
        # blog.css directives will be loaded after main.css and thus will prevail
        echo '#title{font-size: x-large;}
        a.p-name{color:black !important;}
        li{margin-bottom:8px;}
        ul,ol{margin-left:24px;margin-right:24px;}
        .subtitle{font-size:small;margin:12px 0px;line-height: 2.3;}
        .content p{margin-left:24px;margin-right:24px;}
        #description{font-size:large;margin-bottom:12px;}
        h2{padding-top:42px;margin-bottom:8px;}

        img{max-width:100%;}
        #twitter{line-height:20px;vertical-align:top;text-align:right;font-style:italic;color:#333;margin-top:24px;font-size:14px;}
/* Microformats */

.h-card {
display: inline-block;
  background: var(--code-background-color);
  border: 3px solid var(--code-background-color);
padding-right:.6rem
}
.u-photo {
width: 1.5rem;
  height: 1.5rem;
  padding: .3rem .6rem 0 .3rem;
vertical-align: text-bottom;}
.p-rsvp {
font-weight:bold
}

/* Sent Webmentions */
.like::before {content:"❤️";padding-right:.66rem;}
.reply::before {content:"🗨️";padding-right:.66rem;}
.bookmark::before {content:"🔖";padding-right:.66rem;}
.rsvp::before {content:"📅";padding-right:.66rem;}


/* Webmention.js */

#webmentions::before {content:"";text-align:center;display:block;}

#webmentions ul{margin-left:0px;padding-left:0}
#webmentions li{list-style-type:none;padding-bottom:1.6rem;}
a.source::after { content: '\A\A';     white-space: pre;}
#webmentions img 
{border-radius:90px;height:2rem;object-fit:cover;margin-right:-10px} 

/* Open heart */

open-heart {
  border:1px solid var(--fg);
  border-radius:.4em;
  padding:.4em
}
open-heart:not([disabled]):hover,
open-heart:not([disabled]):focus {
  border-color:var(--link-color);
  cursor:pointer
}
open-heart[disabled] {
  background:var(--code-color);
  color:var(--code-background-color);
  cursor:not-allowed
}

open-heart[count]:not([count="0"])::after {
  content:attr(count);
	padding-left:.5rem;
}
' > blog.css
    fi

    # If there is a style.css from the parent page (i.e. some landing page)
    # then use it. This directive is here for compatibility with my own
    # home page. Feel free to edit it out, though it doesn't hurt
    if [[ -f ../style.css ]] && [[ ! -f main.css ]]; then
        ln -s "../style.css" "main.css" 
    elif [[ ! -f main.css ]]; then
# This is the CSS from https://bearblog.dev/, adjusted slightly
echo ":root {
    --width: 800px;
    --font-main: Verdana, sans-serif;
    --font-secondary: Verdana, sans-serif;
    --font-scale: 1em;
    --background-color: #fff;
    --heading-color: #222;
    --text-color: #444;
    --link-color: #3273dc;
    --visited-color:  #8b6fcb;
    --code-background-color: #f2f2f2;
    --code-color: #222;
    --blockquote-color: #222;
}

@media (prefers-color-scheme: dark) {
    :root {
        --background-color: #01242e;
        --heading-color: #eee;
        --text-color: #ddd;
        --link-color: #8cc2dd;
        --visited-color:  #8b6fcb;
        --code-background-color: #000;
        --code-color: #ddd;
        --blockquote-color: #ccc;
    }
}

body {
    font-family: var(--font-secondary);
    font-size: var(--font-scale);
    margin: auto;
    padding: 20px;
    max-width: var(--width);
    text-align: left;
    background-color: var(--background-color);
    word-wrap: break-word;
    overflow-wrap: break-word;
    line-height: 1.5;
    color: var(--text-color);
}


.h-feed article {
padding:21px;
padding-bottom: 42px;
margin-bottom:10px;
border-left: 2px solid var(--text-color);
padding-top:0;
background:  var(--code-background-color)
}

hr {border:none}

footer {
    padding: 25px 0;
    text-align: center;
}


h1, h2, h3, h4, h5, h6 {
    font-family: var(--font-main);
    color: var(--heading-color);
}

a {
    color: var(--link-color);
    cursor: pointer;
    text-decoration: none;
}

a:hover {
    text-decoration: underline; 
}


nav a {
    margin-right: 8px;
}

strong, b {
    color: var(--heading-color);
}

button {
    margin: 0;
    cursor: pointer;
}

main {
    line-height: 1.6;
}

table {
    width: 100%;
}


time {
 	font-family: monospace;
  	font-style: normal;
  	font-size: 15px;

hr {
    border: 0;
    border-top: 1px dashed;
}

img {
    max-width: 100%;
}

code {
    font-family: monospace;
    padding: 2px;
    background-color: var(--code-background-color);
    color: var(--code-color);
    border-radius: 3px;
}

blockquote {
    border-left: 1px solid #999;
    color: var(--code-color);
    padding-left: 20px;
    font-style: italic;
}

footer {
    padding: 25px 0;
    text-align: center;
}

.title:hover {
    text-decoration: none;
}

.title h1 {
    font-size: 1.5em;
}

.inline {
    width: auto !important;
}

.highlight, .code {
    padding: 1px 15px;
    background-color: var(--code-background-color);
    color: var(--code-color);
    border-radius: 3px;
    margin-block-start: 1em;
    margin-block-end: 1em;
    overflow-x: auto;
}

/* blog post list */
ul.blog-posts {
    list-style-type: none;
    padding: unset;
}

ul.blog-posts li {
    display: flex;
}

ul.blog-posts li span {
    flex: 0 0 130px;
}

ul.blog-posts li a:visited {
    color: var(--visited-color);

}" > main.css

    fi
}

# Regenerates all the single post entries, keeping the post content but modifying
# the title, html structure, etc
rebuild_all_entries() {
    echo -n "Rebuilding all entries "

    for i in ./*.html; do
        is_boilerplate_file "$i" && continue;
        contentfile=.tmp.$RANDOM
        while [[ -f $contentfile ]]; do contentfile=.tmp.$RANDOM; done

        echo -n "."
        # Get the title and entry, and rebuild the html structure from scratch (divs, title, description...)
        title=$(get_post_title "$i")

        get_html_file_content 'text' 'text' <"$i" >> "$contentfile"

        # Read timestamp from post, if present, and sync file timestamp
        timestamp=$(awk '/<!-- '$date_inpost': .+ -->/ { print }' "$i" | cut -d '#' -f 2)
        [[ -n $timestamp ]] && touch -t "$timestamp" "$i"
        # Read timestamp from file in correct format for 'create_html_page'
        timestamp=$(LC_ALL=C date -r "$i" +"$date_format_full")

        create_html_page "$contentfile" "$i.rebuilt" no "$title" "$timestamp" "$(get_post_author "$i")"
        # keep the original timestamp!
        timestamp=$(LC_ALL=C date -r "$i" +"$date_format_timestamp")
        mv "$i.rebuilt" "$i"
        chmod 644 "$i"
        touch -t "$timestamp" "$i"
        rm "$contentfile"
    done
    echo ""
}

# Displays the help
usage() {
    echo "$global_software_name v$global_software_version"
    echo "Usage: $0 command [filename]"
    echo ""
    echo "Commands:"
    echo "    post [-html] [filename] insert a new blog post, or the filename of a draft to continue editing it"
    echo "                            it tries to use markdown by default, and falls back to HTML if it's not available."
    echo "                            use '-html' to override it and edit the post as HTML even when markdown is available"
    echo "    edit [-n|-f] [filename] edit an already published .html or .md file. **NEVER** edit manually a published .html file,"
    echo "                            always use this function as it keeps internal data and rebuilds the blog"
    echo "                            use '-n' to give the file a new name, if title was changed"
    echo "                            use '-f' to edit full html file, instead of just text part (also preserves name)"
    echo "    delete [filename]       deletes the post and rebuilds the blog"
    echo "    rebuild                 regenerates all the pages and posts, preserving the content of the entries"
    echo "    reset                   deletes everything except this script. Use with a lot of caution and back up first!"
    echo "    list                    list all posts"
    echo "    tags [-n]               list all tags in alphabetical order"
    echo "                            use '-n' to sort list by number of posts"
    echo ""
    echo "For more information please open $0 in a code editor and read the header and comments"
}

# Delete all generated content, leaving only this script
reset() {
    echo "Are you sure you want to delete all blog entries? Please write \"Yes, I am!\" "
    read -r line
    if [[ $line == "Yes, I am!" ]]; then
        rm .*.html ./*.html ./*.css ./*.rss &> /dev/null
        echo
        echo "Deleted all posts, stylesheets and feeds."
        echo "Kept your old '.backup.tar.gz' just in case, please delete it manually if needed."
    else
        echo "Phew! You dodged a bullet there. Nothing was modified."
    fi
}

# Detects if GNU date is installed
date_version_detect() {
	date --version >/dev/null 2>&1
	if (($? != 0));  then
		# date utility is BSD. Test if gdate is installed 
		if gdate --version >/dev/null 2>&1 ; then
            date() {
                gdate "$@"
            }
		else
            # BSD date
            date() {
                if [[ $1 == -r ]]; then
                    # Fall back to using stat for 'date -r'
                    format=${3//+/}
                    stat -f "%Sm" -t "$format" "$2"
                elif [[ $2 == --date* ]]; then
                    # convert between dates using BSD date syntax
                    command date -j -f "$date_format_full" "${2#--date=}" "$1" 
                else
                    # acceptable format for BSD date
                    command date -j "$@"
                fi
            }
        fi
    fi    
}

# Main function
# Encapsulated on its own function for readability purposes
#
# $1     command to run
# $2     file name of a draft to continue editing (optional)
do_main() {
    # Detect if using BSD date or GNU date
    date_version_detect
    # Load default configuration, then override settings with the config file
    global_variables
    [[ -f $global_config ]] && source "$global_config" &> /dev/null 
    global_variables_check

    # Check for $EDITOR
    [[ -z $EDITOR ]] && 
        echo "Please set your \$EDITOR environment variable. For example, to use nano, add the line 'export EDITOR=nano' to your \$HOME/.bashrc file" && exit

    # Check for validity of argument
    [[ $1 != "reset" && $1 != "post" && $1 != "rebuild" && $1 != "list" && $1 != "edit" && $1 != "delete" && $1 != "tags" ]] && 
        usage && exit

    [[ $1 == list ]] &&
        list_posts && exit

    [[ $1 == tags ]] &&
        list_tags "$@" && exit

    if [[ $1 == edit ]]; then
        if (($# < 2)) || [[ ! -f ${!#} ]]; then
            echo "Please enter a valid .md or .html file to edit"
            exit
        fi
    fi

    # Test for existing html files
    if ls ./*.html &> /dev/null; then
        # We're going to back up just in case
        tar -c -z -f ".backup.tar.gz" -- *.html &&
            chmod 600 ".backup.tar.gz"
    elif [[ $1 == rebuild ]]; then
        echo "Can't find any html files, nothing to rebuild"
        exit
    fi

    # Keep first backup of this day containing yesterday's version of the blog
    [[ ! -f .yesterday.tar.gz || $(date -r .yesterday.tar.gz +'%d') != "$(date +'%d')" ]] &&
        cp .backup.tar.gz .yesterday.tar.gz &> /dev/null

    [[ $1 == reset ]] &&
        reset && exit

    create_css
    create_includes
    [[ $1 == post ]] && write_entry "$@"
    [[ $1 == rebuild ]]  && rebuild_all_entries && rebuild_tags
    [[ $1 == delete ]] && rm "$2" &> /dev/null && rebuild_tags
    if [[ $1 == edit ]]; then
        if [[ $2 == -n ]]; then
            edit "$3"
        elif [[ $2 == -f ]]; then
            edit "$3" full
        else
            edit "$2" keep
        fi
    fi
    rebuild_index
    all_posts
    all_tags
    make_rss
    delete_includes
}


#
# MAIN
# Do not change anything here. If you want to modify the code, edit do_main()
#
do_main "$@"

# vim: set shiftwidth=4 tabstop=4 expandtab:
