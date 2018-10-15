#include <stdio.h>
#include <dlfcn.h>


int main (void)
{
   void *hnd   = NULL,
        *start = NULL,
        *end   = NULL;
   char aux[50];
   const char resourceName[] = "file_txt";


   hnd = dlopen (NULL, RTLD_LAZY|RTLD_NOW);
   if (!hnd){
      printf ("\r\n ****** [ERROR!] dlopen() %s", dlerror ());
      return 0;
   }

   sprintf (aux, "_binary_%s_start", resourceName);
   start = dlsym (hnd, aux);
   if (!start){
      printf ("\r\n ****** [ERRO!] dlsym (%s) %s", aux, dlerror ());
      dlclose (hnd);
      return 0;
   }

   sprintf (aux, "_binary_%s_end", resourceName);
   end = dlsym (hnd, aux);
   if (!end){
      printf ("\r\n ****** [ERRO!] dlsym (%s) %s", aux, dlerror ());
      dlclose (hnd);
      return 0;
   }

   // TODO.: 'size' symbol...
   
   printf  ("\r\nShow Resource [%s] size [%d].\r\n", (char *) start, (int) (end - start));
   dlclose (hnd);

   return 0;
}