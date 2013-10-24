module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  grunt.initConfig
    pkg: pkg
    path:
      sass: 'sass'
      coffee: 'js'
      build: '.tmp'
      diffs: 'docroot/_diffs'
      components: 'bower_components'

    sass:
      build:
        expand: true
        src: ['<%= path.sass %>/**/*.{sass,scss}', '!<%= path.sass %>/**/_*']
        dest: '<%= path.build %>'
        ext: '.css'
      options:
        loadPath: '<%= path.components %>'
    coffee:
      build:
        expand: true
        src: ['<%= path.coffee %>/**/*.coffee']
        dest: '<%= path.build %>'
        ext: '.js'
    concat:
      build:
        files: [
          src: ['<%= path.build %>/<%= path.sass %>/**/*.css']
          dest: '<%= path.diffs %>/css/custom.css'
        ,
          src: ['<%= path.build %>/<%= path.coffee %>/**/*.js']
          dest: '<%= path.diffs %>/js/neu.js'
        ,
          src: [
            '<%= path.components %>/angular-1.1.x/angular.js'
            '<%= path.components %>/angular-1.1.x/angular-mobile.js'
            '<%= path.components %>/cabin-utils/dist/preload.js'
            '<%= path.components %>/cabin-utils/dist/isRetina.js'
            '<%= path.components %>/cabin-utils/dist/at2x.js'
            '<%= path.components %>/cabin-utils/dist/scrolling.js'
            '<%= path.components %>/greensock-js/src/uncompressed/TweenLite.js'
            '<%= path.components %>/greensock-js/src/uncompressed/TimelineLite.js'
            '<%= path.components %>/greensock-js/src/uncompressed/plugins/CSSPlugin.js'
            '<%= path.components %>/greensock-js/src/uncompressed/plugins/ScrollToPlugin.js'
          ]
          dest: '<%= path.diffs %>/js/vendor.js'
        ]

    watch:
      sass:
        files: ['<%= path.sass %>/**/*.{sass,scss}']
        tasks: ['deploy']

  # Load tasks from all required grunt plugins.
  for dep of pkg.devDependencies when dep.indexOf('grunt-') is 0
    grunt.loadNpmTasks(dep)

  grunt.registerTask('build', [
    'sass'
    'coffee'
    'concat'
  ])
  grunt.registerTask 'antDeploy', 'Run "ant deploy"', ->
    grunt.util.spawn({cmd: 'ant', args: ['deploy']}, @async())
  grunt.registerTask('deploy', 'Compile and deploy to Liferay', [
    'build'
    'antDeploy'
  ])
  grunt.registerTask('dev', 'Deploy on file changes', ['deploy', 'watch'])
