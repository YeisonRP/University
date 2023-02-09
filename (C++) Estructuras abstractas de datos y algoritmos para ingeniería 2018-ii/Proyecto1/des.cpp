#include "des.h"

des::des(){

};

des::~des(){

};
long long int des::getByte(int longitud, int posicion, long long int bytes){
	int bit;
	bytes = bytes >> longitud - posicion;
	bit = (int)bytes & 1;
	return bit;
};

void des::setByte(int longitud, int posicion, long long int &bytes, long long int bit){
	long long int i = 1;
	i = i << longitud - posicion;

	i = ~i;
	bytes = bytes & i;

	long long int bit2= bit;
	bit2 = bit2 << longitud - posicion;

	bytes = bytes | bit2;
};

long long int des::permutar(int *arregloPermutar, int longitudArreglo, long long int llaveAPermutar, int longitudLLaveApermutar,int longitudLlavePermutada ){
	long long int LlavePermutada = 0;
	for(int i = 0; i<longitudArreglo; i++){
		setByte(longitudLlavePermutada,(i+1),LlavePermutada,getByte(longitudLLaveApermutar,arregloPermutar[i],llaveAPermutar)); 
	}
	return LlavePermutada;
};

void des::generando16Llaves(long long int *arregloLlaves, long long int C_0, long long int D_0 ){
	long long int bitC, bitD, C_n[17], D_n[17], C_n_copia, D_n_copia ;
	int mascara = 0xFFFFFFF;
	C_n[0] = C_0;
	D_n[0] = D_0;
	int shifts[16] = {1,1,2,2,2,2,2,2,1,2,2,2,2,2,2,1};
	for(int i = 0; i < 16; i++){
		C_n_copia = C_n[i];
		D_n_copia = D_n[i];
		for(int j = 1; j <= shifts[i]; j++){
			//obtener bit 1
			bitC = getByte(28,1, C_n_copia);
			bitD = getByte(28,1, D_n_copia);
			//shiftear a la izq
			C_n_copia = C_n_copia << 1;
			D_n_copia = D_n_copia << 1;
			if(j == 1){ 
				C_n[i+1] = mascara & (C_n_copia);
				D_n[i+1] = mascara & (D_n_copia);
			}
			else{C_n[i+1] = C_n[i+1] << 1; D_n[i+1] = D_n[i+1] << 1; }
			C_n_copia = mascara & (C_n_copia);
			D_n_copia = mascara & (D_n_copia);
			//ponerlo al inicio (28)
			setByte(28,28,C_n[i+1],bitC);
			setByte(28,28, D_n[i+1],bitD);
		}
	}

	//listas las C y D
	// haciendo con C D llaves de 56 bits
	for(int i = 0; i < 16; i++){ 
		arregloLlaves[i] = D_n[i+1] | (C_n[i+1] << 28);
	}
	// permutando las llaves
	int permutacion2[48] ={14,17,11,24,1,5,3,28,15,6,21,10,23,19,12,4,26,8,16,7,27,20,13,2,41,52,31,37,47,55,30,40,51,45,33,48,44,49,39,56,34,53,46,42,50,36,29,32};

	for(int i = 0; i < 16; i++){ 
		arregloLlaves[i] = permutar(permutacion2,48,arregloLlaves[i],56, 48);
	}
};

long long int des::S_function(long long int num,long long int fila,long long int columna){
	long long int S[512]={14,4,13,1,2,15,11,8,3,10,6,12,5,9,0,7,
					0,15,7,4,14,2,13,1,10,6,12,11,9,5,3,8,
					4,1,14,8,13,6,2,11,15,12,9,7,3,10,5,0,
					15,12,8,2,4,9,1,7,5,11,3,14,10,0,6,13,
					15,1,8,14,6,11,3,4,9,7,2,13,12,0,5,10,
					3,13,4,7,15,2,8,14,12,0,1,10,6,9,11,5,
					0,14,7,11,10,4,13,1,5,8,12,6,9,3,2,15,
					13,8,10,1,3,15,4,2,11,6,7,12,0,5,14,9,
					10,0,9,14,6,3,15,5,1,13,12,7,11,4,2,8,
					13,7,0,9,3,4,6,10,2,8,5,14,12,11,15,1,
					13,6,4,9,8,15,3,0,11,1,2,12,5,10,14,7,
					1,10,13,0,6,9,8,7,4,15,14,3,11,5,2,12,
					7,13,14,3,0,6,9,10,1,2,8,5,11,12,4,15,
					13,8,11,5,6,15,0,3,4,7,2,12,1,10,14,9,
					10,6,9,0,12,11,7,13,15,1,3,14,5,2,8,4,
					3,15,0,6,10,1,13,8,9,4,5,11,12,7,2,14,
					2,12,4,1,7,10,11,6,8,5,3,15,13,0,14,9,
					14,11,2,12,4,7,13,1,5,0,15,10,3,9,8,6,
					4,2,1,11,10,13,7,8,15,9,12,5,6,3,0,14,
					11,8,12,7,1,14,2,13,6,15,0,9,10,4,5,3,
					12,1,10,15,9,2,6,8,0,13,3,4,14,7,5,11,
					10,15,4,2,7,12,9,5,6,1,13,14,0,11,3,8,
					9,14,15,5,2,8,12,3,7,0,4,10,1,13,11,6,
					4,3,2,12,9,5,15,10,11,14,1,7,6,0,8,13,
					4,11,2,14,15,0,8,13,3,12,9,7,5,10,6,1,
					13,0,11,7,4,9,1,10,14,3,5,12,2,15,8,6,			
					1,4,11,13,12,3,7,14,10,15,6,8,0,5,9,2,
					6,11,13,8,1,4,10,7,9,5,0,15,14,2,3,12,
					13,2,8,4,6,15,11,1,10,9,3,14,5,0,12,7,
					1,15,13,8,10,3,7,4,12,5,6,11,0,14,9,2,
					7,11,4,1,9,12,14,2,0,6,10,13,15,3,5,8,
					2,1,14,7,4,10,8,13,15,12,9,0,3,5,6,11};
	return (S[(num-1)*64+fila*16+columna]);
	
};

long long int des::f_function(const long long int R_n_1,const long long int K_n){

	//E YA ESTA
	int E_bit_selection_table[48]={32,1,2,3,4,5,4,5,6,7,8,9,8,9,10,11,12,13,12,13,14,15,16,17,16,17,18,19,20,21,20,21,22,23,24,25,24,25,26,27,28,29,28,29,30,31,32,1};
	long long int E = 0;
	for(int i = 1; i <= 48; i++){
		setByte(48,i,E,getByte(32,E_bit_selection_table[i-1],R_n_1));
	}

	// XOR con key
	long long int K_xor_E = 0;
	K_xor_E = E ^ K_n; //listo

	// calculando S
	long long int fila = 0;
	long long int columna = 0;
	long long int S = 0;
	for(int i = 1; i <= 8; i++){
	
		fila = 0;
		columna = 0;

		setByte(2,1,fila,getByte(48,1,K_xor_E));
		setByte(2,2,fila,getByte(48,6,K_xor_E));

		for(int j = 2; j<=5;j++){
			columna = columna << 1;
			columna = columna | getByte(48,j,K_xor_E);	
		}

		K_xor_E = K_xor_E << 6;	
		long long int mascara3 = 0xFFFFFFFFFFFF;
		K_xor_E = K_xor_E & mascara3;

		S = S << 4;
		S = S | S_function(i,(int)fila,(int)columna);

	}
	
	int permutacion4[32]={16,7,20,21,29,12,28,17,1,15,23,26,5,18,31,10,2,8,24,14,32,27,3,9,19,13,30,6,22,11,4,25};
	return permutar(permutacion4,32,S,32,32);
};

long long int des::encriptarConLLaves(long long int *llaves, long long int R_0, long long int L_0){

	long long int R_n[17];
	long long int L_n[17];
	for(int j = 0; j<17;j++){
		R_n[j] = 0;
		L_n[j] = 0;
	}
	L_n[0] = L_0;
	R_n[0] = R_0;
	L_n[1] = R_0;
	R_n[1] = L_0 ^ (f_function(R_0, llaves[0]));

	int i = 2;
	for(i=2; i <= 16; i++){
		L_n[i] = R_n[i-1];
		R_n[i] = L_n[i-1] ^ (f_function(R_n[i-1], llaves[i-1])); //xor
	}
	long long int IP = R_n[16] << 32;
	IP = IP | L_n[16];
	int permutacion5[64]={40,8,48,16,56,24,64,32,39,7,47,15,55,23,63,31,38,6,46,14,54,22,62,30,37,5,45,13,53,21,61,29,36,4,44,12,52,20,60,28,35,3,43,11,51,19,59,27,34,2,42,10,50,18,58,26,33,1,41,9,49,17,57,25};
	long long int IP1 = permutar(permutacion5,64,IP,64,64);
	return IP1;
};

long long int des::encriptar(string TextoAEncriptar, string llaveParaEncriptar){
	
		long long int llaveInicial[8]={llaveParaEncriptar[0],llaveParaEncriptar[1],llaveParaEncriptar[2],llaveParaEncriptar[3],llaveParaEncriptar[4],llaveParaEncriptar[5],llaveParaEncriptar[6],llaveParaEncriptar[7]};
		int x = TextoAEncriptar.length() / 8;
		int j = 0;
		long long int mensajeInicial[8];
		char imprimir[8];
		for(int i=0; i<=x;i++){
			
			
			for(int g = 0; g < 8; g++){
				imprimir[g] = TextoAEncriptar[i*8 + g];
				mensajeInicial[g] = TextoAEncriptar[i*8 + g];
			}
			
	
			long long int msg=0;
			long long int key=0;
			
			int flag = 0;
			if(x == i){
				int y = TextoAEncriptar.length() % 8;
				flag = 1;
				if(y != 0){
					flag = 0;
					for(int h = 0; h<8;h++){
						mensajeInicial[h]=0;
					}
					
					for(int k = 0; k<(TextoAEncriptar.length() - 8*x); k++){ 
						mensajeInicial[k] = TextoAEncriptar[8*x+k];
						
					}
				}
				
			}
			
			if(flag == 0){

			
				for (int k=0;k<8;k++){
					msg= msg +(mensajeInicial[k]<<((7-k)*8));
				}
				for (int l=0;l<8;l++){
					key= key + (llaveInicial[l]<<((7-l)*8));
				}
		/////////PROCESANDO LA LLAVE //////////////////////
				
				//////////////////Inicio obteniendo llave de 56 bit 
				long long int key2; //K+
				int permutacion1[56]={57,49,41,33,25,17,9,1,58,50,42,34,26,18,10,2,59,51,43,35,27,19,11,3,60,52,44,36,63,55,47,39,31,23,15,7,62,54,46,38,30,22,14,6,61,53,45,37,29,21,13,5,28,20,12,4};
				key2 = permutar(permutacion1, 56, key, 64, 56); // retorna llave permutada
				//////////////////FIN obteniendo llave de 56 bit 

				////// Cortar la llave key2 en la mitad, 28 bits
				long long int mascara = 0xFFFFFFF;
				long long int D_0	= key2 & mascara;
				long long int C_0 = key2 >> 28; 
				C_0 = C_0 & mascara;
				////// FIN cortar la llave key2 en la mitad

				//GENERANDO LAS 16 LLAVES INICIO
				long long int *LlavesCD = new long long int[16];	//LLAVES
				generando16Llaves(LlavesCD,C_0, D_0 );
				//GENERANDO LAS 16 LLAVES FIN


		/////////PROCESANDO EL MENSAJE //////////////////////


				///MENSAJE PERMUTACION INICIO
				int permutacion3[64]={58,50,42,34,26,18,10,2,60,52,44,36,28,20,12,4,62,54,46,38,30,22,14,6,64,56,48,40,32,24,16,8,57,49,41,33,25,17,9,1,59,51,43,35,27,19,11,3,61,53,45,37,29,21,13,5,63,55,47,39,31,23,15,7};
				long long int IP = permutar(permutacion3,64,msg,64,64);	
				// MENSAJE PERMUTACION FINAL	
				
				////// Cortar IP  en la mitad, 32 bits
				long long int mascara2 = 0xFFFFFFFF;
				long long int R_0	= IP & mascara2;
				long long int L_0 = IP >> 32; 
				L_0 = L_0 & mascara2;
				////// FIN cortar IP en la mitad
				
				// encriptar
				j =i+1;
				cout << "Bloque encriptado en hexadecimal numero " << j << ":  ";
				cout << hex << encriptarConLLaves(LlavesCD,R_0,L_0);
				cout << "    Bloque de texto: ";
				for(int f = 0; f < 8; f++){
					
					cout << imprimir[f];
				}
				cout << endl;
			}
		

		}
		
};
