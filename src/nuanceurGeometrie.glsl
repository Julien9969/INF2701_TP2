#version 410

uniform mat4 matrModel;
uniform mat4 matrVisu;
uniform mat4 matrProj;

layout(triangles) in;
layout(triangle_strip, max_vertices = 3) out;

in Attribs {
    vec4 couleur;
} AttribsIn[];

out Attribs {
    vec4 couleur;
    vec3 lumiDir;
    vec3 normale, obsVec;
} AttribsOut;

void main()
{
    // calculer le centre
    // vec4 centre = vec4(0.0);
    // for ( int i = 0 ; i < gl_in.length() ; ++i )
    //     centre += gl_in[i].gl_Position;
    // centre /= gl_in.length();

    // Calcule Matr normale
    //mat3 matrVM = mat3( matrVisu * matrModel );
    //mat3 matrNormale = inverse( matrVM );    
   
    // // calculer la normale (N) qui sera interpol�e pour le nuanceur de fragments
    //AttribsOut.normale = matrNormale * Normal;
    //
    // // calculer la position (P) du sommet (dans le rep�re de la cam�ra)
    //vec3 pos = vec3( matrVisu * matrModel * Vertex );
    //
    // // calculer le vecteur de la direction (L) de la lumi�re (dans le rep�re de la cam�ra)
    // AttribsOut.lumiDir = ( matrVisu * LightSource.position ).xyz - pos;
    //
    // // calculer le vecteur de la direction (O) vers l'observateur (dans le rep�re de la cam�ra)
    // AttribsOut.obsVec = ( LightModel.localViewer ?
    //                       (-pos) :        // =(0-pos) un vecteur qui pointe vers le (0,0,0), c'est-�-dire vers la cam�ra
    //                      vec3( 0.0, 0.0, 1.0 ) ); // on consid�re que l'observateur (la cam�ra) est � l'infini dans la direction (0,0,1)


    // �mettre les sommets
    for ( int i = 0 ; i < gl_in.length() ; ++i )
    {

        vec3 arete1 = vec3( gl_in[1].gl_Position - gl_in[0].gl_Position);
        vec3 arete2 = vec3( gl_in[2].gl_Position - gl_in[0].gl_Position );
        AttribsOut.normale = cross ( arete1 , arete2 );

        // AttribsOut.normale = vec3(1,1,1);
        AttribsOut.obsVec = vec3( 0, 0, 1 );
        AttribsOut.lumiDir = vec3( 0, 0, 1 );        
        
        // AttribsOut.obsVec = vec3( 0, 0, 1);
        // AttribsOut.lumiDir = vec3( 0, 0, 1 );
        AttribsOut.couleur = AttribsIn[i].couleur;
        EmitVertex();
    }
    //EndPrimitive();
}