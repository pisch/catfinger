FasdUAS 1.101.10   ��   ��    k             l     ��  ��      GetTotp.scpt     � 	 	    G e t T o t p . s c p t   
  
 l     ��������  ��  ��        l     ��  ��    B < Get a timed on-time password from your yubikey and paste it     �   x   G e t   a   t i m e d   o n - t i m e   p a s s w o r d   f r o m   y o u r   y u b i k e y   a n d   p a s t e   i t      l     ��������  ��  ��        l     ��  ��    / ) get the account alias from the clipboard     �   R   g e t   t h e   a c c o u n t   a l i a s   f r o m   t h e   c l i p b o a r d      l    	 ����  r     	    l     ����  I    ���� 
�� .JonsgClp****    ��� null��    �� ��
�� 
rtyp  m    ��
�� 
ctxt��  ��  ��    o      ���� 0 the_account  ��  ��       !   l     �� " #��   " : 4 get the one-time password of the account from ykman    # � $ $ h   g e t   t h e   o n e - t i m e   p a s s w o r d   o f   t h e   a c c o u n t   f r o m   y k m a n !  % & % l  
  '���� ' r   
  ( ) ( l  
  *���� * I  
 �� +��
�� .sysoexecTEXT���     TEXT + b   
  , - , b   
  . / . m   
  0 0 � 1 1 X / u s r / l o c a l / b i n / y k m a n   o a t h   a c c o u n t s   c o d e   - s   ' / o    ���� 0 the_account   - m     2 2 � 3 3  '��  ��  ��   ) o      ���� 0 the_code  ��  ��   &  4 5 4 l     �� 6 7��   6 2 , copy the one-time password to the clipboard    7 � 8 8 X   c o p y   t h e   o n e - t i m e   p a s s w o r d   t o   t h e   c l i p b o a r d 5  9 : 9 l    ;���� ; I   �� <��
�� .JonspClpnull���     **** < o    ���� 0 the_code  ��  ��  ��   :  = > = l     ��������  ��  ��   >  ? @ ? l     �� A B��   A I C enter each of the characters of the clipboard followed by a return    B � C C �   e n t e r   e a c h   o f   t h e   c h a r a c t e r s   o f   t h e   c l i p b o a r d   f o l l o w e d   b y   a   r e t u r n @  D E D l   ; F���� F X    ; G�� H G O  , 6 I J I I  0 5�� K��
�� .prcskprsnull���     ctxt K o   0 1���� 0 ch  ��   J m   , - L L�                                                                                  sevs  alis    \  Macintosh HD               ߯�BD ����System Events.app                                              ����߯�        ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  �� 0 ch   H o     ���� 0 the_code  ��  ��   E  M N M l  < F O���� O O  < F P Q P I  @ E�� R��
�� .prcskprsnull���     ctxt R o   @ A��
�� 
ret ��   Q m   < = S S�                                                                                  sevs  alis    \  Macintosh HD               ߯�BD ����System Events.app                                              ����߯�        ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��   N  T�� T l     ��������  ��  ��  ��       �� U V��   U ��
�� .aevtoappnull  �   � **** V �� W���� X Y��
�� .aevtoappnull  �   � **** W k     F Z Z   [ [  % \ \  9 ] ]  D ^ ^  M����  ��  ��   X ���� 0 ch   Y �������� 0 2������������ L����
�� 
rtyp
�� 
ctxt
�� .JonsgClp****    ��� null�� 0 the_account  
�� .sysoexecTEXT���     TEXT�� 0 the_code  
�� .JonspClpnull���     ****
�� 
kocl
�� 
cobj
�� .corecnte****       ****
�� .prcskprsnull���     ctxt
�� 
ret �� G*��l E�O��%�%j E�O�j O �[��l kh  � �j U[OY��O� �j U ascr  ��ޭ