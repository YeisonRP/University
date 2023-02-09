
#include <iostream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <netinet/in.h>
#include <math.h>
/*
 *  Cache simulation project
 *  Class UCR IE-521
 *  Semester: I-2019
*/

#ifndef L1CACHE_H
#define L1CACHE_H

#include <netinet/in.h> 
/* 
 * ENUMERATIONS 
 */

/* Return Values */
enum returns_types {
 OK,
 PARAM,
 ERROR
};

/* Type of optimization */
enum replacement_policy{
  VC,
  L2,
  NONE
};


enum miss_hit_status {
 MISS_LOAD,
 MISS_STORE,
 HIT_LOAD,
 HIT_STORE
};

enum coherence {            // Estados de coherencia
  INVALID,
  SHARED,
  MODIFIED,
  EXCLUSIVE,
  NONE_
};

/*
 * STRUCTS
 */

/* Cache tag array fields */
struct entry {
 enum coherence state;          // Estado de coherencia en el bloque 
 bool valid ;
 bool dirty ;
 int tag ;
 uint8_t rp_value ;
};

/* Cache replacement policy results */
struct operation_result {
 enum miss_hit_status miss_hit;
 bool dirty_eviction;
 int  evicted_address;
 bool evicted_block;    //Para saber si salio un bloque
};


/* Cache L2 replacement policy results */
struct operation_result_L2 {
 int MissL1;
 int HitL1;
 int MissL2;
 int HitL2;
 int dirty_eviction;
 int  evicted_addressL1;
 int  evicted_addressL2;
};
//////////////////////////////////////////////////


//////////////////////////////////////////////////

/* 
 *  Functions
 * /

/*
 * Get tag, index and offset length
 * 
 * [in] cache_size: total size of the cache in Kbytes
 * [in] associativity: number of ways of the cache
 * [in] blocksize_bytes: size of each cache block in bytes
 *
 * [out] tag_size: size in bits of the tag field
 * [out] idx_size: size in bits of the index field
 * [out] offset_size: size in bits of the offset size
 */
int field_size_get(int cachesize_kb,
                   int associativity,
                   int blocksize_bytes,
                   int *tag_size,
                   int *idx_size,
                   int *offset_size);

/* 
 * Get tag and index from address
 * 
 * [in] address: memory address
 * [in] tag_size: number of bits of the tag field
 * [in] idx_size: number of bits of the index field
 *
 * [out] idx: cache line idx
 * [out] tag: cache line tag
 */

void address_tag_idx_get(long address,
                         int tag_size,
                         int idx_size,
                         int offset_size,
                         int *idx,
                         int *tag);


/* 
 * Search for an address in a cache set and
 * replaces blocks using LRU policy
 * 
 * [in] idx: index field of the block
 * [in] tag: tag field of the block
 * [in] associativity: number of ways of the entry
 * [in] opt: tipo de optimizacion con la que debe trabajar la politica
 * [in] loadstore: type of operation true if store false if load
 * [in] debug: if set to one debug information is printed
 *
 * [in/out] cache_block: return the cache operation return (miss_hit_status)
 * [out] result: result of the operation (returns_types)
 */
int lru_replacement_policy (int idx,
                           int tag,
                           int associativity,
                           bool loadstore,
                           entry* cache_blocks,
                           operation_result* operation_result,
                           bool debug=false);



/* 
 * Search for an address in a cache set and
 * replaces blocks using LRU policy
 * 
 * [in] idx: index field of the block
 * [in] tag: tag field of the block
 * [in] associativity: number of ways of the entry
 * [in] opt: tipo de optimizacion con la que debe trabajar la politica
 * [in] loadstore: type of operation true if store false if load
 * [in] debug: if set to one debug information is printed
 *
 * [in/out] cache_block: return the cache operation return (miss_hit_status)
 * [out] result: result of the operation (returns_types)
 */
int lru_L1_L2_replacement_policy (int idx,
                           int tag,
                           int idxL2,
                           int tagL2,
                           int associativity,
                           bool loadstore,
                           entry* cache_blocks,
                           entry* cache_blocksL2,                           
                           operation_result_L2* operation_result_L2,
                           bool debug=false);


/* 
 * Crea una matriz que representa la memoria cache
 * donde las filas son los sets, y las columnas son
 * las vias.
 * 
 * [in] idx_size: Numero de bits del indice
 * [in] associativity: Numero de vias de la cache
 *
 * [out] cantidad_sets: Cantidad de sets en la cache
 */
entry** creando_matriz_cache  (int idx_size,
                            int associativity,
                            int *cantidad_sets);





void simulation_outL2( int cache_size_kb, 
                       int associativity,  
                       int block_size,   
                       operation_result_L2* L2
                       );


/* 
 * Search for the coherence_state of a specific
 * block in a cache set
 * 
 * [in] tag: tag field of the block
 * [in] associativity: number of ways of the entry
 * [in] cache_block: cache block
 * [out] return: return the coherence state of the data (INVALID,SHARED,MODIFIED,EXCLUSIVE),
 *               if the tag is not in the block, return NONE_
 */
coherence get_coherence_state ( int tag,
                                int associativity,
                                entry* cache_blocks);


/* 
 * Set the coherence_state of a specific
 * block
 * 
 * [in] tag: tag field of the block
 * [in] associativity: number of ways of the entry
 * [in] cache_block: cache block
 * [in] coherence_state: new coherence_state of the data (INVALID,SHARED,MODIFIED,EXCLUSIVE)
 */
void set_coherence_state (int tag,
                          int associativity,
                          entry* cache_blocks,
                          coherence coherence_state);


#endif


/*

PROTOCOLO MESI para un bloque llamado  bloque1 (que esta por ejemplo en el set 3 way 2) en el L1 del CORE 1

if(HAY HIT DEL bloque1 EN L1)
{ 
  if(bloque1 tiene estado I) 
  {

    PREGUNTAS. 
	Si estaba invalido el bloque y pasa a exclusivo, significa que
    	se tuvo que traer el dato de MM. En este caso seria un hit de todas formas?

	Si hay miss en L1 y hit en L2, se copia el dato junto con el estado en ambos?

	Que significa lo de coherency de los resultados a imprimir?

    if(Era un read)
    {
       se debe buscar en la L1 del otro core y en L2, si esta en alguna de estas se debe pasar
       al estado S todos los bloques (excepto si estan en I). (funciones get y set? u otra)

       En caso contrario pasa a E
    }
    
    if(Era un write)
    {
       Se debe pasar al estado modificado, y verificar si esta en el L1 del otro core o L2 para ponerlo I
    }
  }

  if(bloque1 tiene estado E)
  {
    if(Era un read)
    {
        Se queda en E. Porque tiene el mismo dato que MM y ninguna otra memoria de la jerarquia tiene el dato
    }
    
    if(Era un write)
    {
        Se pasa al estado M. 
    } 
  }
  if(bloque1 tiene estado S)
  {
      if(Era un read)
      {
          Se queda en S
      }
      
      if(Era un write)
      {
          Se pasa al estado M. SE debe mandar mensaje a L2 y al otro core para que invalide el dato
      }  
  }
  if(bloque1 tiene estado M)
  {
    if(Era un read)
    {
        se queda en M
    }
    
    if(Era un write)
    {
        se queda en M
    }    
  }
}

if(HAY miss DEL bloque1 EN L1 y hit en L2)
{ 
se hace lo mismo que en el anterior solo que ahora solo se debe verificar el otro core para ver si 
tiene el dato y acomodarlo segun corresponda.

El dato de L2 y el core 1 es el mismo despues del miss del core 1 y hit de L2
}

    

 */


#define KB 1024
#define ADDRSIZE 32
using namespace std;
int field_size_get( int cachesize_kb,
                    int associativity,
                    int blocksize_bytes,
                    int *tag_size,
                    int *idx_size,
                    int *offset_size)
{
  //-----------------------Verificando que los parametros sean multiplos de dos----------------------:
  double cachesize_kb_double, associativity_double, blocksize_bytes_double;
  cachesize_kb_double = log2((double)cachesize_kb*KB);
  associativity_double = log2((double)associativity);
  blocksize_bytes_double = log2((double)blocksize_bytes);   
  if(cachesize_kb_double - (int)cachesize_kb_double != 0 || associativity_double - (int)associativity_double != 0 || blocksize_bytes_double - (int)blocksize_bytes_double != 0)
  { return ERROR;   }

  //-------------------- Verificando que ningun dato sea negativos------------------------------------
   if(cachesize_kb < 0 || associativity <= 0 || blocksize_bytes <= 0){  return ERROR;   }

  //-------------------------------- Calculando offset----------------------------------------------: 
  *offset_size = log2((double)blocksize_bytes);

  // -------------------------------Calculando idx_size---------------------------------------------: 
  *idx_size = log2((double) ((( cachesize_kb*KB ) / blocksize_bytes ) / associativity) );

  //--------------------------------- Calculando tag_size---------------------------------------------:
  *tag_size = ADDRSIZE - *idx_size - *offset_size;

  //------------------------------ Si el tag_size es menor que 0, error-----------------------------
  if(*tag_size < 0)
  {  return ERROR;  }

  //------------------------------ Si todo esta bien retorna OK -----------------------------
  return OK;  
}

void address_tag_idx_get(long address,
                        int tag_size,
                        int idx_size,
                        int offset_size,
                        int *idx,
                        int *tag)
{

   int mascara1 = 0x7FFFFFFF;
   int dir = address;
//------------------------------ Calculando el Index -----------------------------
   *idx = address << tag_size;
   *idx = *idx >> 1;
   *idx = *idx & mascara1;
   *idx = *idx >> (tag_size + offset_size - 1);
//------------------------------ Calculando el Tag -----------------------------
   *tag = dir >> 1;
   *tag = *tag & mascara1;
   *tag = *tag >> (idx_size + offset_size - 1) ;
}


///////////////////////////////////////////// NO SE USA ///////////////////////////////////////////////////////////////

// TESTEADA
int lru_replacement_policy (int idx,
                             int tag,
                             int associativity,
                             bool loadstore,
                             entry* cache_blocks,  // set de la cache
                             operation_result* result,
                             bool debug)
{
//------------------------------ Verificar si tag e index son validos -----------------------------
   if (idx < 0 || tag < 0 ) {    return ERROR;   }

//------------------------------ Verificar si asociatividad es valido -----------------------------
   double associativity_double = log2((double)associativity); 
   if(associativity_double - (int)associativity_double != 0) {  return ERROR;   } 
     

   result->evicted_block = false;      //--- se asume que no salio ningun bloque
   bool hit_o_miss = false;
//------------------------------ Verificar Si es Hit -----------------------------
   for(int i = 0; i < associativity; i++)
   {
      if(cache_blocks[i].tag == tag && cache_blocks[i].valid)
      {  //---------------------ocurrio un hit----------------------
         for(int j = 0; j < associativity; j++)
         {
            if(cache_blocks[j].rp_value < (cache_blocks[i].rp_value)){  cache_blocks[j].rp_value += 1;   }  //suma 1 a la politica de remplazo
         }
         hit_o_miss = true;
         cache_blocks[i].rp_value = 0;
         result->dirty_eviction = false;
         result->evicted_address = 0; 
         if(loadstore)  
         {  //------- si es un hit store-----------
            cache_blocks[i].dirty = true; 
            result->miss_hit = HIT_STORE; 
         }
         else           
         {  //------- si es un hit load------------
            result->miss_hit = HIT_LOAD;   
         }
         //------------Terminando el for-----------
         i = associativity;
      }
   }
//------------------------------ Se encontro que es un miss -----------------------------
   if(!hit_o_miss){
      for(int i = 0; i < associativity; i++)
      {
         if(cache_blocks[i].rp_value == (associativity - 1))   
         {  //----------------si es el bloque del set con menos prioridad---------------------------
            if (cache_blocks[i].valid == 1)  //-- si el bloque con asosiatividad - 1 es valido, quiere decir
            {                                //-- que va a salir ese bloque
               result->evicted_block = true;
            }
            
            result->evicted_address = (cache_blocks[i].valid)? cache_blocks[i].tag: 0 ; 
            
            cache_blocks[i].valid = 1;                      //---- Es valido ya que se va a escribir sobre el----
            cache_blocks[i].tag = tag;                      //-----tag nuevo guardado en el set----------
            result->dirty_eviction = (cache_blocks[i].dirty)? true: false;   //----Si hubo dirty eviction-----
            if(loadstore)  
            {  // -----------si hubo miss store----------------
               cache_blocks[i].dirty = true;   
               result->miss_hit = MISS_STORE;    
            }
            else           
            {  // --------------si hubo miss load---------------
               cache_blocks[i].dirty = false;   
               result->miss_hit = MISS_LOAD;    
            }
            for(int j = 0; j < associativity; j++)
            {  //----------suma 1 a los valores de remplazo correspondientes ----------------
               if(cache_blocks[j].rp_value < (associativity - 1))
               {  
                  cache_blocks[j].rp_value += 1;   
               }  
            }
            cache_blocks[i].rp_value = 0; //---- el dato que se ingreso/guardo con remplazo en 0-----
            i = associativity;            // ---- Termina el for ----
         } 
      }
   }


   return OK;
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

int lru_L1_L2_replacement_policy (int idx,
                           int tag,
                           int idxL2,
                           int tagL2,
                           int associativity,
                           bool loadstore,
                           entry* cache_blocks,
                           entry* cache_blocksL2,                           
                           operation_result_L2* operation_result_L2,
                           bool debug)
{
//------------------------------ Verificar si tag e index son validos -----------------------------
   if (idx < 0 || tag < 0 || tagL2 < 0 || idxL2 < 0) {    return ERROR;   }

//------------------------------ Verificar si asociatividad es valido -----------------------------
   double associativity_double = log2((double)associativity); 
   if(associativity_double - (int)associativity_double != 0) {  return ERROR;   } 
     
// -------------------- Creando asociatividad para L2 y otras variables del sistema ----------------
   int associativityL2 = associativity * 2;

   bool hit_o_missL1 = false;
   bool hit_o_missL2 = false;
//------------------------------ Verificar Si es Hit en L1-----------------------------
   for(int i = 0; i < associativity; i++)
   {
      if(cache_blocks[i].tag == tag && cache_blocks[i].valid)
      {  //---------------------ocurrio un hit en L1 ----------------------
         for(int j = 0; j < associativity; j++)
         {
            if(cache_blocks[j].rp_value < (cache_blocks[i].rp_value)){  cache_blocks[j].rp_value += 1;   }  //suma 1 a la politica de remplazo
         }
         hit_o_missL1 = true;                   // Declara al sistema que hubo hit en L1
         cache_blocks[i].rp_value = 0;          // Le asigna valor de remplazo 0.
         operation_result_L2->HitL1 +=1; 
         operation_result_L2->evicted_addressL1 = 0; // no sale nada de L1 por que es un hit.
         
         if(loadstore){  
            //------- si es un hit store-----------
            //--------- Busca el tag en L2 para ponerlo sucio-------
            for(int a = 0; a < associativityL2; a++){
               if(cache_blocksL2[a].tag == tagL2){
                  cache_blocksL2[a].dirty = true;
                  a = associativityL2;
               }
            }
         }
         // -----------Actualizando el valor de reemplazo en L2
            for(int i = 0; i < associativityL2; i++){
               if(cache_blocksL2[i].tag == tagL2 && cache_blocksL2[i].valid){  
                  for(int j = 0; j < associativityL2; j++){
                     if(cache_blocksL2[j].rp_value < (cache_blocksL2[i].rp_value)){  cache_blocksL2[j].rp_value += 1;   }  //suma 1 a la politica de remplazo
                  }                           
                  cache_blocksL2[i].rp_value = 0;  
                  i = associativityL2;     
               }
            }
         //------------Terminando el for-----------
         i = associativity;
      }
   }
//------------------------------ Se encontro que es un miss en L1 -----------------------------
   if(!hit_o_missL1){
      operation_result_L2->MissL1 +=1;

      //------------------------Busca en L2----------------------------------------------
      for(int i = 0; i < associativityL2; i++){
         if(cache_blocksL2[i].tag == tagL2 && cache_blocksL2[i].valid){  
            
            //---------------------ocurrio un hit en L2 ----------------------
            for(int j = 0; j < associativityL2; j++){
               if(cache_blocksL2[j].rp_value < (cache_blocksL2[i].rp_value)){  cache_blocksL2[j].rp_value += 1;   }  //suma 1 a la politica de remplazo
            }
            hit_o_missL2 = true;                  // Indica al sistema que hubo un hit en L2
            cache_blocksL2[i].rp_value = 0;       // Asiga un cero al valor de reemplazo
            operation_result_L2->HitL2 += 1; 
            if(loadstore){  
               //------- si es un hit store pone sucio el dato en L2 -----------
               cache_blocksL2[i].dirty = true; 
            }

          //------------------------ Guarda el dato en L1-------------------------------
            for(int m = 0; m < associativity; m++){
               
               //----------------si es el bloque del set con menos prioridad---------------------------
               if(cache_blocks[m].rp_value == (associativity - 1)){  
                  operation_result_L2->evicted_addressL1 = (cache_blocks[m].valid)? cache_blocks[m].tag: 0 ; 
                  cache_blocks[m].valid = 1;                      //---- Es valido ya que se va a escribir sobre el----
                  cache_blocks[m].tag = tag;                      //-----tag nuevo guardado en el set----------

                //----------suma 1 a los valores de remplazo correspondientes ----------------
                  for(int j = 0; j < associativity; j++){  
                     if(cache_blocks[j].rp_value < (associativity - 1)){  cache_blocks[j].rp_value += 1;   }  
                  }
                  cache_blocks[m].rp_value = 0; //---- el dato que se ingreso/guardo con remplazo en 0-----
                  m = associativity;            // ---- Termina el for ----
               } 
            }

          //------------Terminando el for-----------   
            i = associativityL2;
         }
      }

      //------------------------------- Hubo un miss en L1 y en L2----------------------------------------------
      if(!hit_o_missL2){
         operation_result_L2->MissL2 +=1;

         //----------------Guarda el nuevo valor en L2 ---------------------------
         for(int i = 0; i < associativityL2; i++){

            //----------------si es el bloque del set con menos prioridad---------------------------
            if(cache_blocksL2[i].rp_value == (associativityL2 - 1)){  
           
               operation_result_L2->evicted_addressL2 = (cache_blocksL2[i].valid)? cache_blocksL2[i].tag: 0 ; 
            
               cache_blocksL2[i].valid = 1;                      //---- Es valido ya que se va a escribir sobre el----
               cache_blocksL2[i].tag = tagL2;                      //-----tag nuevo guardado en el set----------
               operation_result_L2->dirty_eviction += (cache_blocksL2[i].dirty)? 1: 0;   //----Si hubo dirty eviction-----
               
               if(loadstore){
               // -----------si hubo miss store----------------
                  cache_blocksL2[i].dirty = true;      
               }
         
               //----------suma 1 a los valores de remplazo correspondientes ----------------
               for(int j = 0; j < associativityL2; j++){  
                  if(cache_blocksL2[j].rp_value < (associativityL2 - 1)){  cache_blocksL2[j].rp_value += 1;   }  
               }
               cache_blocksL2[i].rp_value = 0; //---- el dato que se ingreso/guardo con remplazo en 0-----
               i = associativityL2;            // ---- Termina el for ----
            } 
         }

         //----------------Guarda el nuevo valor en L1 ---------------------------
         for(int i = 0; i < associativity; i++){

            //----------------si es el bloque del set con menos prioridad---------------------------
            if(cache_blocks[i].rp_value == (associativity - 1)){  
               operation_result_L2->evicted_addressL1 = (cache_blocks[i].valid)? cache_blocks[i].tag: 0 ; 
               cache_blocks[i].valid = 1;                      //---- Es valido ya que se va a escribir sobre el----
               cache_blocks[i].tag = tag;                      //-----tag nuevo guardado en el set----------
               
               //----------suma 1 a los valores de remplazo correspondientes ----------------
               for(int j = 0; j < associativity; j++){  
                  if(cache_blocks[j].rp_value < (associativity - 1)){  cache_blocks[j].rp_value += 1; }  
               }
               cache_blocks[i].rp_value = 0; //---- el dato que se ingreso/guardo con remplazo en 0-----
               i = associativity;            // ---- Termina el for ----
            } 
         }      
      }      
   }
   return OK;
}



entry** creando_matriz_cache  (int idx_size,
                            int associativity,
                            int *cantidad_sets)
{
   //----------------Cantidad de sets = filas matriz -----------------------
   *cantidad_sets = pow(2,idx_size);  

   //-----------Creando matriz memoria dinamica de datos tipo entry---------
   entry **cache_matrix = new entry*[*cantidad_sets];
   for(int i = 0; i < *cantidad_sets; i++)
   {
      cache_matrix[i] = new entry[associativity];
   }

   //---------------------Inicializando valores de la cache-----------------
   for(int i = 0; i < *cantidad_sets; i++)
   {
      for(int j = 0; j < associativity; j++)
      {
         cache_matrix[i][j].valid = 0;
         cache_matrix[i][j].dirty = 0;
         cache_matrix[i][j].rp_value = associativity - 1;
         cache_matrix[i][j].tag = 0;
      } 
   }
   //-----------------Retorna puntero de la matriz----------------------
   return cache_matrix;
}
      
void simulation_outL2( int cache_size_kb, 
                     int associativity, 
                     int block_size,  
                     int cp, 
                     operation_result_L2* L2)
   {
      double L1MR = (double)L2->MissL1/double(L2->MissL1+L2->HitL1);
      double L2MR = (double)L2->MissL2/double(L2->MissL2+L2->HitL2);
      double GMR = L1MR*L2MR;
      double OMR = double(L2->MissL1+L2->MissL2)/double(L2->MissL1+L2->HitL1);

      cout << "------------------------------------------\n";
            cout << "  Cache parameters:\n";
            cout << "------------------------------------------\n";
            cout << "  L1 Cache Size (KB): "<<"          " << cache_size_kb << "\n";
            cout << "  L2 Cache Size (KB): "<<"          " << cache_size_kb*4 << "\n";
            cout << "  Cache L1 Associativity: "<<"      " << associativity << "\n";
            cout << "  Cache L2 Associativity: "<<"      " << associativity*2 << "\n";
            cout << "  Cache Block Size (bytes):"<<"     " << block_size << "\n";
            cout << "  Coherence protocol                " <<  "\n";
            cout << "------------------------------------------\n";
            cout << "  Simulation results:\n";
            cout << "------------------------------------------\n";
            cout << "  Overall miss rate"<<"               " << OMR <<"\n";
            cout << "  CPU1 L1 miss rate:"<<"              " << L1MR <<"\n";
            cout << "  CPU2 L2 miss rate:"<<"              " << L2MR<<"\n";
            cout << "  Coherence Invalidation CPU1"<<"     " << GMR <<"\n";
            cout << "  Coherence Invalidation CPU2"<<"     " << GMR <<"\n";
            cout << "------------------------------------------\n";
   }       

coherence get_coherence_state (int tag,
                               int associativity,
                               entry* cache_blocks)
{

   for (int i = 0; i < associativity; i++)
   {
      if (cache_blocks[i].tag == tag & cache_blocks[i].dirty == 0)   //-- Si se encuentra el dato y no esta sucio
      {
         return cache_blocks[i].state; //-- Retorna el estado si encontro el dato
      }
   }
   return NONE_; //-- Si no encontro el dato en el set retorna un NONE_

}


void set_coherence_state (int tag,
                          int associativity,
                          entry* cache_blocks,
                          coherence coherence_state)
{

   for (int i = 0; i < associativity; i++)
   {
      if (cache_blocks[i].tag == tag)
      {
         cache_blocks[i].state = coherence_state; // Escribe el dato
      }
   }
}

int main(int argc, char * argv []) {
   int sizeCacheKB = 64;
   int associativity = 4;
   int sizeBloqBytes = 8;
  //-----------------Se calculan los tamanos del tag, index y offset-----------------

  int status = 0;   // Para saber si una funcion retono error
  int statusL2 = 0;
  int * tag_size = new int;       //tamano del tag
  int * tag_sizeL2 = new int;       //tamano del tag
  int * index_size = new int;     //tamano del index
  int * index_sizeL2 = new int;     //tamano del index
  int * offset_size = new int;    //tamano del offset
  int * misses = new int;                   // miss opt VC
  int * hits = new int;                     // hits opt VC
  int * VC_hits = new int;                  // VC_hits opt VC
  int * dirty_evictions = new int;          // dirty_evictions opt VC
  int * cantidad_sets = new int;
  // Verificando los tamanos de tag index y offset
  status = field_size_get(sizeCacheKB,associativity,sizeBloqBytes,tag_size,index_size,offset_size);
  
  statusL2 = field_size_get(sizeCacheKB*4,associativity*2,sizeBloqBytes,tag_sizeL2,index_sizeL2,offset_size);


  entry ** C1_L1 = creando_matriz_cache(*index_size,associativity,cantidad_sets);
  entry ** C2_L1 = creando_matriz_cache(*index_size,associativity,cantidad_sets);
  entry ** L2 = creando_matriz_cache(*index_sizeL2,associativity*2,cantidad_sets); 

   int asd = 3;
   int asd2 = 2;
   for (int i = 0; i < associativity; i++)
   {
      C1_L1[0][i].tag = asd;
      C1_L1[0][i].dirty = 0;
      C1_L1[0][i].state = MODIFIED;

      C2_L1[0][i].tag = asd2;
      C2_L1[0][i].dirty = 0;
      C2_L1[0][i].state = SHARED;
      asd += 1;
      asd2 += 1;
   }
   cout << get_coherence_state(3,4,C2_L1[0]) << endl; // debe dar 1
   set_coherence_state(3,4,C2_L1[0],INVALID);
     cout << get_coherence_state(4,4,C2_L1[0]) << endl; // debe dar 0
return 0;
}




