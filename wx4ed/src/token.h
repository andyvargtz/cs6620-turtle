
/* Tokens.  */
#define GO 258
#define TURN 259
#define VAR 260
#define JUMP 261
#define FOR 262
#define STEP 263
#define TO 264
#define DO 265

// BEGIN END {}
#define COPEN 266
#define CCLOSE 267

// sin cos sqrt
#define SIN 268
#define COS 269
#define SQRT 270
#define FLOAT 271
#define ID 272
#define NUMBER 273
#define SEMICOLON 274

// +-*/
#define PLUS 275
#define MINUS 276
#define TIMES 277
#define DIV 278

// ()
#define OPEN 279
#define CLOSE 280
// =
#define ASSIGN 281

#define UP 282
#define DOWN 283

#define NORTH 284
#define EAST 285
#define WEST 286
#define SOUTH 287
 
#define IF 288
#define THEN 289
#define ELSE 290

#define GREATER 291
#define LESS 292
#define EQUAL 293
#define GE 294
#define LE 295

#define WHILE 296

#define PROCEDURE 297
#define COMMA 298

#define NE 299



typedef union YYSTYPE
{ int i; node *n; double d;}
        YYSTYPE;
YYSTYPE yylval;

