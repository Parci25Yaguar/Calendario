Algoritmo B_X_S_J__EJERCICIO_45
	// Declaraci�n de variables
	Definir dateC Como Cadena;
	Definir year,month,day,fDM,D,dW Como Entero;
	Definir S,OK Como Logico;
	Definir seguir Como Caracter;
	S <- Verdadero;
	Escribir "**** CALENDARIO DEL A�O ****"
	Mientras S Hacer
		// Pedir por teclado la fecha indicando el formato
		Escribir 'INTRODUCE UNA FECHA (DD/MM/AAAA)....' Sin Saltar;
		Leer dateC;
		// Comprobar que la fecha es v�lida
		OK=isDateOk(dateC);								
		Si OK Entonces				// Si la fecha es correcta
			day=ConvertirANumero(Subcadena(dateC,1,2));
			month=ConvertirANumero(Subcadena(dateC,4,5));
			year=ConvertirANumero(Subcadena(dateC,7,10));
			fDM=firstDayMonth(year,month);     // Primer d�a del mes
			D=(day-1)%7;
			dW=fDM+D;       // D�a de la semana en que cae la fecha
			Si (dW>7) Entonces
				dW=dW-7;
			FinSi
			Escribir "";
			Escribir "";
			Escribir "LA FECHA " + dateC + " CAE EN " + dayWeekText(dW);
			Escribir "";
			Escribir "";
		SiNo					// Si la fecha no es correcta
			Escribir 'FECHA INCORRECTA. INT�NTALO DE NUEVO.';
		FinSi
		Escribir 'Pulsar la tecla S para continuar ...' Sin Saltar;
		Leer seguir;
		Si ((seguir=='S') O (seguir=='s')) Entonces
			S <- Verdadero;
		SiNo
			S <- Falso;
		FinSi
	FinMientras
FinAlgoritmo


// Comprueba que la fecha tiene el formato correcto
// y que es una fecha v�lida
Funcion OK <- isDateOk(dateC)
	// Declarar variables
	Definir OK Como Logico;
	Definir lDate, month, year, day Como Entero;
	
	lDate=Longitud(dateC);
	Si (lDate <> 10) Entonces
		OK=Falso;				// La cadena no tiene 10 caracteres, luego es incorrecta
	SiNo
		// Comprobar si los caracteres de separaci�n son los correctos
		OK=separadorOk(dateC);
		Si OK Entonces
			// Comprobar que los dem�s caracteres sean todos num�ricos
			OK=isNumberDate(dateC);
			Si OK Entonces
				// Si todos son num�ricos convertir a n�mero para poder calcular
				day=ConvertirANumero(Subcadena(dateC,1,2));
				month=ConvertirANumero(Subcadena(dateC,4,5));
				year=ConvertirANumero(Subcadena(dateC,7,10));
				// Comprobar si el mes es correcto
				OK=monthOk(month);
				Si OK Entonces
					// Comprobar si el a�o es correcto
					OK=yearOK(year);
					Si OK Entonces
						OK=dayOk(day,month,year);
					FinSi
				FinSi
			FinSi
		FinSi
	FinSi
FinFuncion

// Comprueba que los caracteres separadores son los correctos
Funcion OK <- separadorOk(dateC)
	Definir OK Como Logico;
	Si ((Subcadena(dateC,3,3)=='/') Y (Subcadena(dateC,6,6)=='/')) Entonces
		OK=Verdadero;
	SiNo
		Si ((Subcadena(dateC,3,3)=='-') Y (Subcadena(dateC,6,6)=='-')) Entonces
			OK=Verdadero;
		SiNo
			OK=Falso;
		FinSi
	FinSi
FinFuncion

// Comprueba que los caracteres del d�a, mes y a�o sean num�ricos
Funcion OK <- isNumberDate(dateC)
	// Declarar variables
	Definir OK Como Logico;
	Definir i Como Entero;
	i=1;
	Mientras i<=10 Hacer
		Si (i==3) O (i==6) Entonces
			i=i+1;
		SiNo
			Si isNumber(Subcadena(dateC,i,i)) Entonces
				OK=Verdadero;
				i=i+1;
			SiNo
				OK=Falso;
				i=11;
			FinSi
		FinSi
	FinMientras
FinFuncion


// Comprueba si el d�a de la fecha es v�lido
Funcion OK <- dayOk(day,month,year)
	// Declarar variables
	Definir OK Como Logico;
	
	Si (day>=1 Y day<=31) Entonces
		Segun day Hacer
			31:
				Si (month==1 O month==3 O month==5 O month==7 O month==8 O month==10 O month==12) Entonces
					OK=Verdadero;
				SiNo
					OK=Falso;
				FinSi
			30:
				Si (month==2) Entonces
					OK=Falso;
				SiNo
					OK=Verdadero;
				FinSi
			29:
				Si (month==1) O (month>=3 Y month<=12) O (month==2) Y (isLeapYear(year)) Entonces
					OK=Verdadero;				
				SiNo
					OK=Falso;
				FinSi
			De Otro Modo:
				OK=Verdadero;	
		Fin Segun
	SiNo
		OK=Falso;
	FinSi
FinFuncion

// Comprueba si el mes de la fecha es v�lido
Funcion OK <- monthOk(month)
	// Declarar variables
	Definir OK Como Logico;
	
	Si (month>=1 Y month<=12) Entonces
		OK=Verdadero;
	SiNo
		OK=Falso;
	FinSi
FinFuncion


// Comprueba si el d�a de la fecha es v�lido
Funcion OK <- yearOk(year)
	// Declarar variables
	Definir OK Como Logico;
	
	Si (year>=1601 Y year<=3000) Entonces
		OK=Verdadero;
	SiNo
		OK=Falso;
	FinSi
	
FinFuncion


// Comprueba si un caracter es un n�mero
Funcion iN <- isNumber(C)
	//Declarar variables
	Definir i Como Entero;
	Definir iN Como Logico;
	Definir num Como Caracter;
	Dimension num[10];
	
	num[1]='0';
	num[2]='1';
	num[3]='2';
	num[4]='3';
	num[5]='4';
	num[6]='5';
	num[7]='6';
	num[8]='7';
	num[9]='8';
	num[10]='9';
	
	// Comprobar si es un n�mero entre 0 y 9
	Para i<-1 Hasta 10 Con Paso 1 Hacer
		Si (C==num[i]) Entonces
			iN=Verdadero;
			i=10;						// Es un n�mero, salir del bucle
		SiNo
			iN=Falso;					// No es un n�mero
		FinSi
	Fin Para
FinFuncion

// Devuelve el d�a de la semana en texto
Funcion dWT <- dayWeekText(dW)
	// Declarar variables
	Definir dWT Como Cadena;
	
	Segun dW Hacer
		1:
			dWT="LUNES";
		2:
			dWT="MARTES";
		3:
			dWT="MI�RCOLES";
		4:
			dWT="JUEVES";
		5:
			dWT="VIERNES";
		6:
			dWT="S�BADO";
		7:
			dWT="DOMINGO";
		De Otro Modo:
			dWT="PARECE QUE HAY ALG�N ERROR";	
	Fin Segun
FinFuncion

// Recibe el a�o (year) y devuelve (lY) si es bisiesto o no
Funcion lY <- isLeapYear(year)
	Definir lY Como Logico;
	// Si el a�o es m�ltiplo de 4
	Si (year MOD 4==0) Entonces
		lY <- Verdadero;
		// Si adem�s es m�ltiplo de 100 y de 400
		Si ((year MOD 100<>0) O (year MOD 400==0)) Entonces
			lY <- Verdadero;
		SiNo
			lY <- Falso;
		FinSi
	SiNo
		lY <- Falso;
	FinSi
FinFuncion

// Recibe el a�o (year) correspondiente y
// devuelve el d�a de la semana (dW) en el que cae el primer d�a de dicho a�o
Funcion dW <- firstDayYear(year)
	Definir dW,i Como Entero;
	Definir lY Como Logico;
	Si year==1601 Entonces
		// Si es 1601, el primer d�a del a�o es Lunes
		dW <- 1;
	SiNo
		// Si el a�o es mayor que 1601
		// Buscar primer d�a del a�o
		dW <- 1; // Se comienza en lunes
		Para i<-1602 Hasta year Hacer
			// Si el año anterior fue bisiesto el d�a la semana
			// habr� que sumarle dos m�s, y sino uno.
			lY <- isLeapYear(i-1);
			Si lY Entonces
				dW <- dW+2;
			SiNo
				dW <- dW+1;
			FinSi
			// Si se llega a 8, es lunes
			Si dW==8 Entonces
				dW <- 1;
			FinSi
			// Si se llega a 9, es martes
			Si dW==9 Entonces
				dW <- 2;
			FinSi
		FinPara
	FinSi
FinFuncion

// Recibe el a�o (year) y mes (month) correspondientes y
// devuelve el d�a de la semana (dW) en el que cae el primer d�a del mes de ese a�o
Funcion dW <- firstDayMonth(year,month)
	// Declarar variables
	Definir fDY,dW,i Como Entero;
	Definir lY Como Logico;
	lY <- isLeapYear(year); // �Es un a�o bisiesto? 
	fDY <- firstDayYear(year); // Primer d�a de la semana del a�o 
	Para i<-1 Hasta month Hacer
		// Si es enero, el primer d�a ser� el primer d�a del a�o
		Si i==1 Entonces
			dW <- fDY;
		FinSi
		// Si es marzo, el primer d�a depender� de si el a�o es bisiesto o no
		Si i==3 Entonces
			Si lY Entonces
				dW <- dW+1;
			SiNo
				dW <- dW;
			FinSi
		FinSi
		// Si es un mes precedido de otro de 31 d�as, se le sumar�n 3 d�as
		Si (i==2) O (i==4) O (i==6) O (i==8) O (i==9) O (i==11) Entonces
			dW <- dW+3;
		FinSi
		// Si es un mes precedido de otro de 30 d�as, se le sumar�n 2 d�as
		Si (i==5) O (i==7) O (i==10) O (i==12) Entonces
			dW <- dW+2;
		FinSi
		// Si llega a 8, es lunes
		Si dW==8 Entonces
			dW <- 1;
		FinSi
		// Si llega a 9, es martes
		Si dW==9 Entonces
			dW <- 2;
		FinSi
		// Si llega a 10, es mi�rcoles
		Si dW==10 Entonces
			dW <- 3;
		FinSi
	FinPara
FinFuncion


