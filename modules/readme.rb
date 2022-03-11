module Readme
    def self.generate( path )
        txt = File.read( path )
        json = JSON.parse( txt )
        data = json.with_indifferent_access

        strs = []
        strs.push( "# Three.js - Cheatsheet" )
        strs.push( "\n" )

        categories = data[:data].map { | a | a[:category] }.uniq().sort
        alpha = 'A'.upto('Z').to_a


        [ '🔰 Basics', '🐈 Advanced', '⛰️ Terrain', '🕹️ Demos',].each.with_index do | category, index | 
        strs.push( "<details closed><summary>#{category}</summary>" )

            strs.push( "\n" )
            selection = data[:data]
                .select { | a | a[:category].eql? category.split(' ').last.downcase }
                .sort_by { | a| a[:name] }
            selection.each.with_index do | project, rindex |
                strs.push( "### #{alpha[rindex]}. #{project[:name]}  " )

                if project.key? :index
                    tmp = project[:index].map.with_index do | a, index |
                        "[#{a}](./#{project[:url].split('/').last}/#{a})"
                    end
                    tmp = tmp.join( ', ')
                else
                    tmp = "[index.html](./#{project[:url].split('/').last})"
                end
                strs.push( "**Demo**: #{tmp}" )
                strs.push( "**Source Code**: [Github](#{project[:url]})" )
                strs.push( self.project( project ) )
                strs.flatten()
            end
            
            strs.push( "  " )
            strs.push( "</details>")
        end

        strs.push( "  " )
        strs.push( "Demos by SimonDev ([Github](https://github.com/simondevyoutube/)/[Youtube](https://www.youtube.com/channel/UCEwhtpXrg5MmwlH04ANpL8A/videos))")
        strs.push( "  " )
        strs.push( "3D Ressources: ")
        strs.push( "- [Mixamo](https://www.mixamo.com/#/)")
        strs.push( "- [Quaternius](https://quaternius.com/packs/texturedfantasynature.html)")
        strs.push( "- [OpenGameArt](https://opengameart.org/art-search-advanced?keys=&field_art_type_tid%5B%5D=10&sort_by=count&sort_order=DESC)")
        strs.push( "- [Poly.Art](https://poly.pizza)")
        strs.push( "- [Zsky](https://zsky2000.itch.io/50-models-of-environment)")
        strs.push( "- [Reddit GameDev](https://www.reddit.com/r/gamedev/search/?q=free%20models&restrict_sr=1&sr_nsfw=)")
        strs.push( "- [GameIcons](https://game-icons.net)")
        strs.push( "- [Threejs Course](https://niklever.github.io/threejs-games-course/)")
        strs.push( "  ")
        strs.push( "Generative 2D/3D: ")
        strs.push( "- [Snowflake](https://www.youtube.com/watch?v=R3C2giDfmO8)")
        strs.push( "- [Polyhedra](http://dmccooey.com/polyhedra/index.html)")
        strs.push( "- [Supershapes](https://editor.p5js.org/carlos.henrique2324@gmail.com/sketches/HJF28pVME)")
        strs.push( "- [Plane Geometry](https://threejs.org/examples/#misc_uv_tests)")
        strs.push( "- [Andrew Marsh](http://andrewmarsh.com/software/)")
        strs.push( "- [Generative Trees](https://github.com/supereggbert/proctree.js/)")
        strs.push( "- [PolyHedronisme](http://levskaya.github.io/polyhedronisme/)")

        return strs.join( "\n" )
    end


    def self.project( project )
        str = []        
        videos = self.videos( project )
        if videos.length > 1
            str = str.push( videos ).flatten()
            str.push( "  " )
            str.push( "  " )
            str.push( "  " )
            str.push( "  " )
            str.push( "  " )
        end

        return str
    end


    def self.videos( data )
        table = []

        data[:youtube].each.with_index do | video, index |
            if index == 0
                table.push( "| Nr | Preview | Name |" )
                table.push( "| :--- | :--- | :--- |" )
            end

            id = video[:url].split("?v=").last

            row = []

            before = "<a href=\"#{video[:url]}\"><img src=\""
            after = ' style="max-width: 100%; height: 100px"></a>'

            str = "#{before}https://img.youtube.com/vi/#{id}/default.jpg\" #{after}"

            row.push( index + 1 )
            row.push( str )
            row.push( "[#{video[:name]}](#{video[:url]})" )


            row = row
                .join( ' | ' )
                .insert( 0, '| ' )
                .concat( ' |' )
            
            table.push( row )
        end

        return table
    end
end