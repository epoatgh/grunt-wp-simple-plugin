###
# ================================================
# grunt-wp-plugin
# https://github.com/10up/grunt-wp-plugin
#
# Copyright (c) 2013 Eric Mann, 10up
#
# Licensed under the MIT License
# ================================================
# Subsequent modifications
# https://github.com/markjaquith/grunt-wp-simple-plugin
#
# Copyright (c) 2016 Mark Jaquith
#
# Licensed under the MIT License
# ================================================
###

# Basic template description
exports.description = 'Create a simple WordPress plugin.'

# Template-specific notes to be displayed before question prompts.
exports.notes = ''

# Template-specific notes to be displayed after the question prompts.
exports.after = ''

# Any existing file or directory matching this wildcard will cause a warning.
exports.warnOn = '*'

# The init template
exports.template = (grunt, init, done) ->
  init.process {}, [
    init.prompt('title', 'WP Plugin')
    {
      name: 'classPrefix'
      message: 'PHP class name (_Plugin is appended)'
      default: 'My_Awesome'
    }
    init.prompt 'description', 'A WordPress plugin'
    init.prompt 'homepage'
    init.prompt 'author_name'
    init.prompt 'author_email'
    init.prompt 'author_url'
  ], (err, props) ->
    props.keywords = []
    props.version = '0.1.0'
    props.private = yes
    props.devDependencies =
      'grunt':                  '~0.4.5'
      'grunt-contrib-watch':    '~0.6.1'
      'grunt-contrib-clean':    '~0.6.0'
      'grunt-contrib-copy':     '~0.7.0'
      'grunt-contrib-compress': '~0.12.0'
      'grunt-text-replace':     '~0.4.0'

    # Class name prefix (e.g. Awesome_Thing)
    props.classPrefix = props.classPrefix.replace /\W+?/gi, '_'

    # Underscored lowercase prefix (e.g. awesome_thing)
    props.prefixUnderscored = props.classPrefix.toLowerCase()

    # Dashed lowercase prefix (e.g. awesome-thing)
    props.name = props.classPrefix.replace(/_/g, '-').toLowerCase()
    props.prefixDashed = props.name

    # All caps prefix (e.g. AWESOME_THING)
    props.prefixUppercase = props.classPrefix.toUpperCase()

    # Files to copy and process
    files = init.filesToCopy props

    # Actually copy and process files
    init.copyAndProcess files, props

    # Generate package.json file
    init.writePackageJSON 'package.json', props

    # Done!
    done()
