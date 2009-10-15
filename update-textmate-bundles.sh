#!/bin/bash

# Copyright 2009 Kevin J. Menard Jr.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

BUNDLE_DIR="$HOME/Library/Application Support/TextMate/Bundles"
GIT=`/usr/bin/env git`

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

if [ ! -d "$BUNDLE_DIR" ]
then
    mkdir -p "$BUNDLE_DIR"
fi

for bundle_name in Ack Git GitHub iPhone jQuery RubyAMP RubyOnRails RSpec Shoulda
do
  bundle="$BUNDLE_DIR/$bundle_name.tmbundle"

  if [ -d "$bundle" ]
  then
    cd "$bundle"
    $GIT pull
  else
    download $bundle_name
  fi
done

/usr/bin/osascript -e 'tell app "TextMate" to reload bundles'