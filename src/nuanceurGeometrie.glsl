#version 410

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

//layout(location=0) in vec4 Vertex;
//layout(location=3) in vec4 Color;

out Attribs {
    vec4 couleur;
    vec3 lumiDir;
    vec3 normale, obsVec;
} AttribsOut;


in Attribs {
    vec4 couleur;
} AttribsIn[];


void main()
{
    //It�ration 3 par 3 ?
    //for ( int i = 0 ; i < gl_in.length() ; ++i )
    //{
    //    vec3 arete1 = vec3(gl_in[1].gl_Position - gl_in[0].gl_Position);
    //    vec3 arete2 = vec3(gl_in[2].gl_Position - gl_in[0].gl_Position);
    //    AttribsOut.normale = cross ( arete1 , arete2 );
    //
    //    AttribsOut.obsVec = vec3( 0, 0, 1 );
    //    AttribsOut.lumiDir = vec3( 0, 0, 1 );  
    //    AttribsOut.couleur = AttribsIn[i].couleur;
    //
    //    EmitVertex();
    //}
    //EndPrimitive();

    for (int i = 0; i < gl_in.length() / 3; i += 3) {
    
        vec3 arete1 = vec3(gl_in[1 + i].gl_Position - gl_in[0 + i].gl_Position);
        vec3 arete2 = vec3(gl_in[2 + i].gl_Position - gl_in[0 + i].gl_Position);
        vec3 Normal = cross ( arete1, arete2 );
        
        for (int j = 0; j < 3; j++) {
            gl_Position = gl_in[i + j].gl_Position;
            
            AttribsOut.couleur = AttribsIn[i + j].couleur;
            AttribsOut.normale = Normal;
            AttribsOut.lumiDir = vec3( 0, 0, 1);  
            AttribsOut.obsVec = vec3( 0, 0, 1 );

            EmitVertex();
        }
    }
}