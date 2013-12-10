module.exports = (grunt)-> 
  process.env.DEBUG = 'dust'
  grunt.initConfig
    clean: ['bin', 'test-bin']
    copy: 
      main:
        files: [{expand: true, cwd: 'resource/', src: ['src'], dest: 'bin/'}]
      test:
        files: [{expand: true, src: ['test'], dest: 'test-bin/'}]
    livescript:
      src:
        files: [
          expand: true
          flatten: true
          cwd: 'src'
          src: ['**/*.ls']
          dest: 'bin/'
          ext: '.js'
        ]
      test:
        files: [
          expand: true
          flatten: true
          cwd: 'test'
          src: ['**/*.ls']
          dest: 'test-bin'
          ext: '.js'
        ]
    watch:
      auto:
        files: ['src/**/*.ls', 'test/**/*.ls']
        tasks: ['livescript', 'copy']
        options:
          spawn: true
    nodemon:
      all:
        options:
          file: 'bin/app.js'
          watchedFolders: ['bin']
    concurrent:
      target:
        tasks:
          ['nodemon', 'watch:auto']
        options:
          logConcurrentOutput: true
  grunt.loadNpmTasks "grunt-livescript"
  grunt.loadNpmTasks "grunt-simple-mocha"
  grunt.loadNpmTasks "grunt-nodemon"
  grunt.loadNpmTasks "grunt-env"
  grunt.loadNpmTasks "grunt-contrib-jshint"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-clean"
  grunt.loadNpmTasks "grunt-concurrent"
  grunt.loadNpmTasks "grunt-contrib-copy"
  grunt.loadNpmTasks "grunt-contrib-concat"

  grunt.registerTask "default", ["clean", "copy", "livescript",  'concurrent']

  grunt.event.on 'watch', (action, filepath)->
    console.log 'filepath: ', filepath
    grunt.config ['livescript', 'src'], filepath
