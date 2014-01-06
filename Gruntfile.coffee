# global module:false
pkg = require './package.json'
exec = require('child_process').exec


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

    #$ grunt publish:my-awesome-draft
    grunt.registerTask 'publish', (postSlug) ->
        fileFound = false

        # Try to find the file.
        possibleExts = ['', '.md', '.html']
        for ext in possibleExts
            filename = postSlug + ext
            src = "_drafts/#{filename}"
            if grunt.file.exists src
                grunt.log.writeln "Draft found at #{src}."
                fileFound = true
                break
            else
                grunt.log.writeln "No draft matching #{postSlug}#{ext}."

        if fileFound
            dest = "_posts/#{dateSlug()}-#{filename}"
            grunt.file.copy src, dest
            grunt.log.ok "Published #{filename} from #{src} as #{dest}"
        else
            grunt.log.error 'Couldn\'t find posts with that name. Here are your options:'
            grunt.log.writeln()
            drafts = grunt.file.expand {cwd: '_drafts'}, '*'
            for draft in drafts
                grunt.log.writeln '- ' + draft


dateSlug = ->
    iso = (new Date).toISOString()
    return iso.substr 0, iso.indexOf('T')
