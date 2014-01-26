module.exports = function(grunt) {
    grunt.initConfig({
        coffee: {
            options: {
                sourceMap: true
            },
            files: {
                expand: true,
                cwd: 'coffee',
                src: '**/*.coffee',
                dest: 'public/js',
                ext: '.js'
            }
        },
        compass: {
            dist: {
                options: {
                    sassDir: 'scss',
                    cssDir: 'public/css'
                }
            }
        },
        watch: {
            coffee: {
                files: ['coffee/**/*.coffee'],
                tasks: ['coffee'],
                options: {
                    spawn: false
                }
            },
            sass: {
                files: ['scss/**/*.scss'],
                tasks: ['compass'],
                options: {
                    spawn: false
                }
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-sass');
    grunt.loadNpmTasks('grunt-contrib-compass');
};

