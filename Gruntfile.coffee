# global module:false
pkg = require './package.json'
module.exports = (grunt) ->

    # Project configuration.
    grunt.initConfig

        banner: """
            /* #{pkg.name} - v#{pkg.version} - #{@template.today('yyyy-mm-dd')}
             * #{pkg.homepage}
             * Copyright (c) #{@template.today('yyyy')} #{pkg.author}
             */\n\n
        """

        cssmin:
            dist:
                expand: true
                cwd: 'css/'
                src: ['*.css', '!*.min.css']
                dest: 'css/'
                ext: '.min.css'

        compass:
            compile:
                options:
                    sassDir: 'sass'
                    cssDir: 'css'

        watch:
            compass:
                files: '<%= compass.compile.options.sassDir %>/*.sass'
                tasks: ['compass', 'cssmin']

    # These plugins provide necessary tasks.
    grunt.loadNpmTasks 'grunt-contrib-concat'
    grunt.loadNpmTasks 'grunt-contrib-compass'
    grunt.loadNpmTasks 'grunt-contrib-cssmin'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    # Default task.
    grunt.registerTask 'default', ['compass', 'cssmin']
