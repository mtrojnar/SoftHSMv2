AC_DEFUN([ACX_OPENSSL_EDDSA],[
	AC_MSG_CHECKING(for OpenSSL EDDSA support)

	tmp_CPPFLAGS=$CPPFLAGS
	tmp_LIBS=$LIBS

	CPPFLAGS="$CPPFLAGS $CRYPTO_INCLUDES"
	LIBS="$CRYPTO_LIBS $LIBS"

	AC_LANG_PUSH([C])
	AC_RUN_IFELSE([
		AC_LANG_SOURCE([[
			#include <openssl/evp.h>
			#include <openssl/objects.h>
			int main()
			{
				EVP_PKEY_CTX *ctx;

				ctx = EVP_PKEY_CTX_new_id(NID_ED25519, NULL);
				if (ctx == NULL)
					return 1;
				return 0;
			}
		]])
	],[
		AC_MSG_RESULT([Found ED25519])
	],[
		AC_MSG_RESULT([Cannot find ED25519])
		AC_MSG_ERROR([OpenSSL library has no EDDSA support])
	],[])
	AC_RUN_IFELSE([
		AC_LANG_SOURCE([[
			#include <openssl/evp.h>
			#include <openssl/objects.h>
			int main()
			{
				EVP_PKEY_CTX *ctx;

				ctx = EVP_PKEY_CTX_new_id(NID_ED448, NULL);
				if (ctx == NULL)
					return 1;
				return 0;
			}
		]])
	],[
		AC_MSG_RESULT([Found ED448])
	],[
		AC_MSG_RESULT([Cannot find ED448])
	],[])
	AC_LANG_POP([C])

	CPPFLAGS=$tmp_CPPFLAGS
	LIBS=$tmp_LIBS
])
