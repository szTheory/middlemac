################################################################################
#  config.rb
#    Configure Middleman to generate Apple HelpBook containers for multiple
#    targets.
################################################################################

##########################################################################
# Targets Configuration
#  Middlemac is capable of building multiple targets for variants of your
#  application using the `middleman-targets` gem. Activate it and change
#  the option values here to suit your needs. Note that middleman-targets
#  adds configuration parameters to the base Middleman application; these
#  are *not* extension options.
##########################################################################
activate :MiddlemanTargets

# Set the default target, i.e, the target that is used automatically when you
# `middleman build` or `middleman server` without the `targets` CLI option.
config[:target] = :pro

# Targets

# NOTE: Ruby has a type of variable called a `symbol`, which are used below
# quite extensively and look like :this_symbol. Except they’re not really
# variables; you can’t assign values to them. Their value is themselves,
# though they have useful string representations (:this_symbol.to_s). You
# can even get the symbol representation of this_string.to_sym. Because
# they're unique, they make excellent array/hash keys and excellent,
# guaranteed unique values.

# :CFBundleID
# Just as different versions of your app must have different bundle identifiers
# so the OS can distinguish them, their help files must have unique bundle IDs,
# too. Your application specifies the help file `CFBundleID` in its
# `CFBundleHelpBookName` entry. Therefore for each target, ensure that your
# application has a `CFBundleHelpBookName` that matches the `CFBundleID` that
# you will set here.

# :HPDBookIconPath
# If specified a target-specific icon will be used as the help book icon by
# Apple’s help viewer. This path must be relative to the location of the
# `Resources` directory per Apple’s specification. If `nil` (or not present) 
# then the default `shared/icon_32x32@2x.png` will be used.

# :CFBundleName
# This value will be used for correct .plists and .strings setup, and will
# determine final .help directory name. All targets should use the same
# :CFBundleName. Built targets will be named `CFBundleName (target).help`.
# This is *not* intended to be a product name, which is defined below.

# :ProductName
# You can specify different product names for each build target. The product
# name for the current target will be available via the `product_name` helper.

# :ProductVersion
# You can specify different product versions for each build target. The
# product version for the current target will be available via the
# `product_version` helper.

# :ProductURI
# You can specify different product URIs for each build target. The URI
# for the current target will be available via the `product_uri` helper.

# (other)
# You can specify additional .plist and .strings keys here, too. Have a look
# at `Info.plist.erb` and `InfoPlist.strings.erb`; simply use the exact key
# name and they will be supported. This is probably unneeded unless you are
# implementing advanced help book features.

# :Features
# A hash of features that a particular target supports or doesn't support.
# The `has_feature` function and several helpers will use the true/false value
# of these features in order to conditionally include content.

config[:targets] = {
        :free =>
            {
                :CFBundleID       => 'com.sample.project.free.help',
                :HPDBookIconPath  => nil,
                :CFBundleName     => 'New Project',
                :ProductName      => 'New Project',
                :ProductVersion   => '2.0.0',
                :ProductURI       => 'http://www.sample.com',
                :features =>
                    {
                        :feature_advertise_pro        => true,
                        :feature_performs_miracles    => false,
                        :feature_insults_user         => true,
                        :feature_shows_pink_rectangle => true,
                    }
            },

        :pro =>
            {
                :CFBundleID       => 'com.sample.project.pro.help',
                :HPDBookIconPath  => nil,
                :CFBundleName     => 'New Project',
                :ProductName      => 'New Project Pro',
                :ProductVersion   => '2.0.0',
                :ProductURI       => 'http://www.sample.com',
                :features =>
                    {
                        :feature_advertise_pro        => false,
                        :feature_performs_miracles    => true,
                        :feature_insults_user         => false,
                        :feature_shows_pink_rectangle => true,
                    }
            },

    } # targets

# By enabling :target_magic_images, target specific images will be used instead
# of the image you specify if it'ss prefixed with :target_magic_word. For
# example, you might request "all-my_image.png", and "pro-my_image.png" (if it
# exists) will be used in your :pro target instead.
#
# Important: when this is enabled, images from *other* targets will *not* be
# included in the build! In the example above, *any* image prefixed with "free-"
# would not be included in the output directory.
config[:target_magic_images] = true
config[:target_magic_word] = 'all'


################################################################
# Page Groups Configuration
#  Middlemac uses the `middleman-pagegroups` gem in order to
#  automate nearly all of the navigation in your help book
#  project.
################################################################
activate :MiddlemanPageGroups do |config|

  # Indicate whether or not numeric file name prefixes used for sorting
  # pages should be eliminated during output. This results in cleaner
  # URI's. Helpers such as `page_name` and Middleman helpers such as
  # `page_class` will reflect the pretty name.
  config.strip_file_prefixes = true

  # Indicates whether or not Middleman's built-in `page_class` helper is
  # extended to include the page_group and page_name.
  config.extend_page_class = true

  # the following options provide defaults for the built-in helpers and
  # sample partials. They'll also work in your own partials and helpers.

  config.nav_breadcrumbs_class = 'breadcrumbs'
  config.nav_breadcrumbs_alt_class = 'breadcrumbs'
  config.nav_breadcrumbs_alt_label = 'Current page'
  config.nav_brethren_class = 'table_contents'
  config.nav_brethren_index_class = 'related-topics'
  config.nav_legitimate_children_class = 'table_contents'
  config.nav_prev_next_class = 'navigate_prev_next'
  config.nav_prev_next_label_prev = 'Previous'
  config.nav_prev_next_label_next = 'Next'
  config.nav_toc_index_class = 'help_map'

end


################################################################
# Extras Configuration
#  Middlemac uses the `middlemac-extras` gem in order to
#  provide other useful tools. They can be configured here.
################################################################
activate :MiddlemacExtras do |config|

  # If set to true, then the enhanced image_tag helper will be used
  # to include @2x srcset automatically, if the image asset exists.
  config.retina_srcset = true

  # If set to true then the `image_tag` helper will work for images even
  # if you don't specify an extension, but only if a file exists on disk
  # that has one of the extensions in :img_auto_extensions_order.
  config.img_auto_extensions = true

  # Set this to an array of extensions in the order of precedence for
  # using `image_tag` without file extensions.
  config.img_auto_extensions_order = %w(.svg .png .jpg .jpeg .gif .tiff .tif)

end


################################################################
# Configuration
#  Change the option values to suit your needs.
################################################################
activate :Middlemac do |options|

  # Directory where finished .help bundle should go. It should be relative
  # to this file, or make nil to leave in this help project directory. The
  # *actual* output directory will be an Apple Help bundle at this location
  # named in the form `#{CFBundleName} (target).help`. You might want to target
  # the `Resources` directory of your XCode project so that your XCode project
  # is always up to date.
  options.Help_Output_Location = nil

  # Indicates the name of the breadcrumbs helper to use for breadcrumbs.
  # Built-in breadcrumbs are "nav_breadcrumbs" and "nav_breadcrumbs_alt".
  # Change to `nil` to disable breadcrumbs completely.
  options.Breadcrumbs = 'nav_breadcrumbs'

  # This was removed in Middleman version 4.0. We are reintroducing it
  # as a Middlemac feature.
  options.partials_dir = 'Resources/Base.lproj/assets/partials'

end #activate


################################################################
# STOP! There's nothing below here that you should have to
# change. Just follow the conventions and framework provided.
################################################################


#===============================================================
# Setup directories to mirror Help Book directory layout.
#===============================================================
set :source,       'Contents'
set :build_dir,    'Contents (build)'

set :fonts_dir,    'Resources/Base.lproj/assets/fonts'
set :images_dir,   'Resources/Base.lproj/assets/images'
set :js_dir,       'Resources/Base.lproj/assets/javascripts'
set :css_dir,      'Resources/Base.lproj/assets/stylesheets'

set :layouts_dir,  'Resources/Base.lproj/assets/_layouts'
set :data_dir,     'Contents/Resources/Base.lproj/assets/_data'


#===============================================================
# Ignore items we don't want copied to the destination
#===============================================================
#ignore 'data/*'


#===============================================================
# All of our links and assets must be relative to the file
# location, and never absolute. However we will *use* absolute
# paths with root being the source directory; they will be
# converted to relative paths at build.
#===============================================================
set :strip_index_file, false
set :relative_links, true
activate :relative_assets do |options|
  options.rewrite_ignore = [/image_sizes\.css/]
end


#===============================================================
# Default to Apple-recommended HTML 4.01 layout.
#===============================================================
set :haml, :format => :html4
page 'Resources/Base.lproj/*.html', :layout => :'layout-html4'


#===============================================================
# Add-on features
#===============================================================
activate :syntax


################################################################################
# Helpers
################################################################################


#===============================================================
# Methods defined in this helpers block are available in
# templates.
#===============================================================
helpers do

  # no helpers here, but the Middlemac class offers quite a few,
  # or you can add your own.

end #helpers


################################################################################
# Build-specific configurations
################################################################################


#===============================================================
# :server - the server is running and watching files.
#===============================================================
configure :server do

  # Reload the browser automatically whenever files change
  # activate :livereload, :host => '127.0.0.1'

  compass_config do |config|
    config.output_style = :expanded
    config.sass_options = { :line_comments => true }
  end

end #configure


#===============================================================
# :build - build is executed specifically.
#===============================================================
configure :build do

  compass_config do |config|
    config.output_style = :expanded
    config.sass_options = { :line_comments => false }
  end

end #configure