// Demo function for reading IRIJULE winbond128q chip:




    ClassicMode = true;
	uint32_t readClassicNoteOffset = (uint32_t)(RootToClassicMultiple[RootIndex] * CLASSICTONEOFFSET);
	uint32_t readScaleOffset;
	uint32_t readClassicVariantOffset;
	uint8_t z = 0;
	uint8_t tNotes[12];
	uint8_t rNotes[12];
	uint8_t rootN=255;
	uint8_t rootSat = 0;

	//uint8_t tmpRootLeft = 24 + RootIndex;

	memset(&ButtonStackOffsets, 0, sizeof(ButtonStackOffsets));

	if((LastClassic <83) || (LastClassic >92)){
		LastClassic = 83;
		LastClassicVariant = 0;
	}


  switch (LastClassic){
	  case 83:
			 memcpy(GlobalScale, scalesByzantineClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesByzantineClassic[LastClassicVariant], 19);
			 LastClassic=83;
			 readScaleOffset = 0x70000;
			 break;
	  case 84:
			 memcpy(GlobalScale, scalesHarmMajorClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesHarmMajorClassic[LastClassicVariant], 19);
			 LastClassic=84;
			 readScaleOffset = 0x0A4800;

			 break;
	  case 85:
			 memcpy(GlobalScale, scalesHarmMinorClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesHarmMinorClassic[LastClassicVariant], 19);
			 LastClassic=85;
			 readScaleOffset = 0x0D9000;


			 break;
	  case 86:
			 memcpy(GlobalScale, scalesMajorClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesMajorClassic[LastClassicVariant], 19);
			 LastClassic=86;
			 readScaleOffset = 0x10D800;


			 break;
	  case 87:
			 memcpy(GlobalScale, scalesMelodicMajorClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesMelodicMajorClassic[LastClassicVariant], 19);
			 LastClassic=87;
			 readScaleOffset = 0x142000;


			 break;
	  case 88:
			 memcpy(GlobalScale, scalesMelodicMinorClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesMelodicMinorClassic[LastClassicVariant], 19);
			 LastClassic=88;
			 readScaleOffset = 0x176800;


			 break;
	  case 89:
			 memcpy(GlobalScale, scalesNeapolitanMajorClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesNeapolitanMajorClassic[LastClassicVariant], 19);
			 LastClassic=89;
			 readScaleOffset = 0x1AB000;
			 break;
	  case 90:
			 memcpy(GlobalScale, scalesNeapolitanMinorClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesNeapolitanMinorClassic[LastClassicVariant], 19);
			 LastClassic=90;
			 readScaleOffset = 0x1DF800;
			 break;
	  case 91:
			 memcpy(GlobalScale, scalesPentatonicClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesPentatonicClassic[LastClassicVariant], 19);
			 LastClassic=91;
			 readScaleOffset = 0x214000;
			 break;
	  case 92:
			 memcpy(GlobalScale, scalesOtherClassic[LastClassicVariant], 25);
			 memcpy(GlobalScaleName, menuScalesOtherClassic[LastClassicVariant], 19);
			 LastClassic=92;
			 readScaleOffset = 0x257800;
			 break;}


  readClassicVariantOffset = (CLASSICLISTOFFSET * LastClassicVariant);
			FlashActive = true;
			__HAL_RCC_SPI3_FORCE_RESET();
			__HAL_RCC_SPI3_RELEASE_RESET();
			MX_SPI3_InitFlash();
			ConfigSPI3();

			        //uint32_t first = 0x66642069;

					W25Q_Read ( ((readScaleOffset+readClassicNoteOffset+readClassicVariantOffset)/256), 0, sizeof(FlashReadBuffer), (uint8_t *)FlashReadBuffer);


			//ReadSettingsToBuffer();

			__HAL_RCC_SPI3_FORCE_RESET();
			__HAL_RCC_SPI3_RELEASE_RESET();
			MX_SPI3_Init();

			FlashActive = false;
			FlashCue = false;

//uint16_t bufferPos=0;
	for(uint8_t x = 0; x < 48; x++)	{ // right grid
		uint8_t cntb=0;

		//uint8_t uintB;
		char charB[8][4] = {0};



		for(uint8_t y = 0; y< 7; y++){

			memcpy(&charB[y], &FlashReadBuffer[(x*0x20)+(y*2)+0x600], 2);
			RightNoteGrid[x][y+2] = (uint8_t)atoi(charB[y]);

			if (RightNoteGrid[x][y+2] !=0) cntb++;

		}
				RightNoteGrid[x][1] = cntb;

				if ((x %4) == 0){
					tNotes[z] = (RightNoteGrid[x][2]%12)+12;
					tNotes[z+7] = (RightNoteGrid[x][2]%12)+12;
					//if(tNotes[z]==0)tNotes[z] = 12;
					z++;
				}

				ledBase[55+x][0] = Colors[ColorAssign[GetStartColor(RightNoteGrid[x][2])]][0];
				ledBase[55+x][1] = Colors[ColorAssign[GetStartColor(RightNoteGrid[x][2])]][1];
				ledBase[55+x][2] = Colors[ColorAssign[GetStartColor(RightNoteGrid[x][2])]][2];

	}





z = 0;
	for(uint8_t x = 0; x < 48; x++)	{ // left grid
		uint8_t cnta=0;

		//uint8_t uintB;
		char charA[8][4] = {0};

		rootN = 255;
	    rootSat = 0;
		for(uint8_t y = 0; y< 7; y++){

			memcpy(&charA[y], &FlashReadBuffer[(x*0x20)+(y*2)], 2);
			rNotes[y] = (uint8_t)atoi(charA[y]);

				if(!rootSat){
					if( (((rNotes[y]%12)+12) == tNotes[z])  && (rNotes[y]!= 0)){
						rootN = rNotes[y];
						rootSat = 1;
					}
				}
			LeftNoteGrid[x][y+2] = (uint8_t)atoi(charA[y]);
			if (LeftNoteGrid[x][y+2] !=0) cnta++;
		}
		if (rootN == 255) {
			z++;
			for(uint8_t y = 0; y< 7; y++){
				if(!rootSat){
					if( (((rNotes[y]%12)+12) == tNotes[z])  && (rNotes[y]!= 0)){
						rootN = rNotes[y];
						rootSat = 1;
					}
				}
			}
		}
		for (uint8_t q = 0; q < 128; q++){
			if(ScaleNotes[q]==rootN) rootN = q;
		}


		for (uint8_t y = 0; y <14; y ++){
			StacksEnabled[x][y] = 0;

			if (StackOffsetsClassic[y] + ScaleNotes[rootN] >= 0){
				ButtonStackOffsets[x][y] = ScaleNotes[rootN+StackOffsetsClassic[y]];
			} else {ButtonStackOffsets[x][y] = 200;}
			for (uint8_t q = 0; q < 7; q++){
				if(rNotes[q]==ButtonStackOffsets[x][y]){
					StacksEnabled[x][y] = 1;
				}
			}
		}

		LeftNoteGrid[x][1] = cnta;

				//memcpy(&charA[7], &FlashReadBuffer[(x*0x20)+14], 2);
				ledBase[7+x][0] = Colors[ColorAssign[GetStartColor(ButtonStackOffsets[x][3])]][0];
				ledBase[7+x][1] = Colors[ColorAssign[GetStartColor(ButtonStackOffsets[x][3])]][1];
				ledBase[7+x][2] = Colors[ColorAssign[GetStartColor(ButtonStackOffsets[x][3])]][2];

	}


} // end classic load func





#define CLASSICLISTOFFSET  0x7800
#define CLASSICTONEOFFSET  0xA00
const uint8_t RootToClassicMultiple[12] = {
		4,//c
		6,//c#/db
		5,//d
		8,//d#/eb
		7,//E
		9,//f
		11,//f#/gb
		10,//g
		1,//g#.ab
		0,// a
		3,//Bb
		2//b
};



