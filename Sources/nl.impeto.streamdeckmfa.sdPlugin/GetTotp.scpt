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
�� .JonspClpnull���     **** < o    ���� 0 the_code  ��  ��  ��   :  = > = l     ��������  ��  ��   >  ? @ ? l     �� A B��   A ? 9 command-v and return on the keyboard using System Events    B � C C r   c o m m a n d - v   a n d   r e t u r n   o n   t h e   k e y b o a r d   u s i n g   S y s t e m   E v e n t s @  D E D l   ( F���� F O   ( G H G I    '�� I J
�� .prcskprsnull���     ctxt I m     ! K K � L L  v J �� M��
�� 
faal M m   " #��
�� eMdsKcmd��   H m     N N�                                                                                  sevs  alis    \  Macintosh HD               ߯�BD ����System Events.app                                              ����߯�        ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��   E  O P O l  ) 3 Q���� Q O  ) 3 R S R I  - 2�� T��
�� .prcskprsnull���     ctxt T o   - .��
�� 
ret ��   S m   ) * U U�                                                                                  sevs  alis    \  Macintosh HD               ߯�BD ����System Events.app                                              ����߯�        ����  
 cu             CoreServices  0/:System:Library:CoreServices:System Events.app/  $  S y s t e m   E v e n t s . a p p    M a c i n t o s h   H D  -System/Library/CoreServices/System Events.app   / ��  ��  ��   P  V�� V l     ��������  ��  ��  ��       �� W X��   W ��
�� .aevtoappnull  �   � **** X �� Y���� Z [��
�� .aevtoappnull  �   � **** Y k     3 \ \   ] ]  % ^ ^  9 _ _  D ` `  O����  ��  ��   Z   [ �������� 0 2������ N K��������
�� 
rtyp
�� 
ctxt
�� .JonsgClp****    ��� null�� 0 the_account  
�� .sysoexecTEXT���     TEXT�� 0 the_code  
�� .JonspClpnull���     ****
�� 
faal
�� eMdsKcmd
�� .prcskprsnull���     ctxt
�� 
ret �� 4*��l E�O��%�%j E�O�j O� 	���l UO� �j Uascr  ��ޭ