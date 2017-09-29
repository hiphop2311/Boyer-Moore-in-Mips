#include<stdio.h>
#include<string.h>

int main(int argc,char *argv){
    char txt[100],pat[100];
    char filename[20];
    int shift,patCount,i;
    int txtlen,patlen;
    int count = 0;
    int table[256];

    printf("input text file (eg. text.txt):");
    gets(filename);
    FILE *f = fopen(filename,"r");
    fgets(txt,100,f);
    fclose(f);
    printf("input pattern:");
    scanf("%s",pat);
    txtlen = strlen(txt);
    patlen = strlen(pat);

    //---------------------PREPROCESSING---------------------------//
    for(i=0;i<256;i++)
        table[i] = patlen;
    for(i=0;i < patlen-1;i++)
        table[pat[i]]  = patlen - i - 1;
    //---------------------SEARCH---------------------------//
    shift = 0;
    while(txtlen - shift >= patlen){
        i = patlen - 1;
        while(i>=0 && txt[shift+i]==pat[i])
            i--;
        if(i<0)
            count++;
        shift += table[txt[patlen+shift-1]];
    }
    if(count == 0)
        printf("no match\n");
    else
        printf("count = %d",count);
    return 0;
}
