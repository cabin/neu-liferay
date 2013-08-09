module.exports = (grunt) ->
  pkg = grunt.file.readJSON('package.json')

  grunt.initConfig
    pkg: pkg
    path:
      sass: 'sass'
      fonts: 'fonts'
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
    concat:
      build:
        src: ['<%= path.build %>/<%= path.sass %>/**/*.css']
        dest: '<%= path.diffs %>/css/custom.css'

    watch:
      sass:
        files: ['<%= path.sass %>/**/*.{sass,scss}']
        tasks: ['deploy']

  # Load tasks from all required grunt plugins.
  for dep of pkg.devDependencies when dep.indexOf('grunt-') is 0
    grunt.loadNpmTasks(dep)

  grunt.registerTask('deploy', 'Compile and deploy to Liferay', [
    'sass'
    'concat'
    'antDeploy'
  ])
  grunt.registerTask 'antDeploy', 'Run "ant deploy"', ->
    grunt.util.spawn({cmd: 'ant', args: ['deploy']}, @async())
  grunt.registerTask('dev', 'Deploy on file changes', ['deploy', 'watch'])
