   %       <   f   u   n   c   t   i   o   n   >       
   %       c   o   m   p   u   t   e   s       D   T   F   T       o   f       l   a   r   g   e       s   e   q   u   e   n   c   e   s       b   y       s   p   l   i   t   t   i   n   g       t   h   e       m   a   t   r   i   x   -   m   u   l   t   i   p   l   i   c   a   t   i   o   n       
   %       m   e   t   h   o   d       o   v   e   r       c   h   u   n   k   s       o   f       w   -   v   a   l   u   e   s   ,       t   o       b   e       a   b   l   e       t   o       h   o   l   d       t   h   e       n   '   *   w       m   a   t   r   i   x       i   n       m   e   m   o   r   y   .   
   %   
   %       <   s   y   n   t   a   x   >   
   %       X   w       =       d   t   f   t   _   s   p   l   i   t   (   x   ,       n   ,       w   ,       <   w   s   p   l   i   t   >   )   
   %   
   %       <   I   /   O   >   
   %       X   w       =       o   u   t   p   u   t       D   T   F   T       s   e   q   u   e   n   c   e       o   v   e   r       r   a   n   g   e       w   
   %       x       =       D   T       s   e   q   u   e   n   c   e       o   v   e   r       r   a   n   g   e       n   
   %       w       =       D   T       f   r   e   q   u   e   n   c   i   e   s       a   r   r   a   y   
   %       w   s   p   l   i   t       =       n   u   m   b   e   r       t   o       w       v   a   l   u   e   s       t   o       i   n   c   l   u   d   e       i   n       o   n   e       c   h   u   n   k       o   f       c   o   m   p   u   t   a   t   i   o   n   
   
   f   u   n   c   t   i   o   n       X   w       =       d   t   f   t   _   s   p   l   i   t   (   x   ,       n   ,       w   ,       w   s   p   l   i   t   )   
   
                   i   f       ~   (   n   a   r   g   i   n   =   =   4   )   ;       w   s   p   l   i   t       =       7   5   0   ;       e   n   d   
                   i   f       w   s   p   l   i   t       <   =       0   
                                   %       o   n   e   -   l   i   n   e       m   a   t   r   i   x   -   m   u   l   t   i   p   l   i   c   a   t   i   o   n       s   o   l   u   t   i   o   n   
                                   X   w       =       x       *       e   x   p   (   -   1   i       *       n   '       *       w   )   ;   
                   e   l   s   e   
                                   %       c   a   l   l       c   h   u   n   k   -   w   i   s   e       m   a   t   r   i   x   -   m   u   l   t   i   p   l   i   c   a   t   i   o   n       m   e   t   h   o   d   
                                   d   t   f   t   _   s   p   l   i   t   _   r   o   u   t   i   n   e   (   )   ;   
                   e   n   d   
                   
                   f   u   n   c   t   i   o   n       d   t   f   t   _   s   p   l   i   t   _   r   o   u   t   i   n   e   
                                   %       c   o   m   p   u   t   e       D   T   F   T       X   (   w   )       u   s   i   n   g       (   c   h   u   n   k   -   w   i   s   e   )       m   a   t   r   i   x   -   m   u   l   t   i   p   i   c   a   t   i   o   n       m   e   t   h   o   d   :   
                                   %                                                               X   w       =       x       *       e   x   p   (   -   1   i       *       n   '       *       w   )   ;   
                                   %       s   p   l   i   t       t   h   i   s       c   o   m   p   u   t   a   t   i   o   n       i   n   t   o       c   h   u   n   k   s   ,   
                                   %       a   s       m   a   t   r   i   x       [   n   '   *   w   ]       r   e   q   u   i   r   e   s       t   o   o       m   u   c   h       m   e   m   o   r   y   
                                   X   w       =       z   e   r   o   s   (   1   ,       l   e   n   g   t   h   (   w   )   )   ;   
                                   w   l   e   n       =       l   e   n   g   t   h   (   w   )   ;   
                                   p   _   b       =       1   :   w   s   p   l   i   t   :   w   l   e   n   ;   
                                   p   _   e       =       [   w   s   p   l   i   t   :   w   s   p   l   i   t   :   w   l   e   n   ,       w   l   e   n   ]   ;   
                                   f   o   r       i               =       1   :   c   e   i   l   (   w   l   e   n   /   w   s   p   l   i   t   )   
                                                   X   w   (       p   _   b   (   i   )   :   p   _   e   (   i   )       )       =       x       *       e   x   p   (   -   1   i       *       n   '       *       w   (       p   _   b   (   i   )   :   p   _   e   (   i   )       )   )   ;   
                                   e   n   d   
                   e   n   d   
   
   e   n   d