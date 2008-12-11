#!/bin/bash

BUNDLE_DIR="$HOME/Library/Application Support/TextMate/Bundles"

function download
{
  cd "$BUNDLE_DIR"
  
  case $1 in
    Ack)
      git clone git://github.com/protocool/ack-tmbundle.git Ack.tmbundle
      ;;
  
    Git)
      git clone git://gitorious.org/git-tmbundle/mainline.git Git.tmbundle
      ;;
    
    GitHub)
      git clone git://github.com/drnic/github-tmbundle.git GitHub.tmbundle
      ;;
      
    RSpec)
      git clone git://github.com/dchelimsky/rspec-tmbundle.git RSpec.tmbundle
      ;;
    
    RubyAMP)
      git clone git://github.com/timcharper/rubyamp.git RubyAMP.tmbundle
      ;;
      
    iPhone)
      git clone git://github.com/drnic/objective-c-iphone-tmbundle.git iPhone.tmbundle
      ;;
      
    jQuery)
      git clone git://github.com/drnic/javascript-jquery-tmbundle.git jQuery.tmbundle
      ;;
    
    RubyOnRails)
      git clone git://github.com/drnic/ruby-on-rails-tmbundle.git RubyOnRails.tmbundle
      ;;
      
    Ruby)
      git clone git://github.com/drnic/ruby-tmbundle.git Ruby.tmbundle
      ;;
      
    Shoulda)
      git clone git://github.com/drnic/ruby-shoulda-tmbundle.git Shoulda.tmbundle
      ;;
  esac
}

for bundle_name in Ack Git GitHub iPhone jQuery RubyAMP RubyOnRails RSpec Shoulda
do
  bundle="$BUNDLE_DIR/$bundle_name.tmbundle"

  if [ -d "$bundle" ]
  then
    cd "$bundle"
    /usr/local/git/bin/git pull
  else
    download $bundle_name
  fi
done

/usr/bin/osascript -e 'tell app "TextMate" to reload bundles'