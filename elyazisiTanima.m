
resim = imread('elYazisi5.png'); // �stenilen resmi bu k�sma yaz�n�z

resimgray = rgb2gray(resim);

resimbin = imbinarize(resimgray);

resim = edge(resimgray, 'sobel');

resim = imdilate(resim,strel('diamond',5));
% imdilate ile strel ile yap�lan morfolojik i�lemlerin
%a�ma i�lemini ger�ekle�tirdik. Kapama i�lemi ise imeorde ile
%yap�lmaktad�r.

resim = imfill(resim, 'holes');
% morfolojik i�lemelerden gelen istenmeyen bo�luklar�n doldurulmas� 
%i�lemlerin� imfill ile yap�yoruz. Yaparkende diyoruz ki bo�luklar� holes
%adl� �zelli�i ile doldur veya d�zelt.(Bo�luktan kas�t g�r�lt�)

resim = imerode(resim, strel('diamond',3)); 
%Morfolojik i�lmelerde kapama i�lemi yap�ld�.

Iprops=regionprops(resim,'BoundingBox','Area', 'Image'); 
% Burada kullan�lan regionprops �zelli�i ile de
%g�r�nt�de almak istedi�imiz nesneleri kopar�p ayr� fig�re olarak
%g�stermeye �al��t�k.

area = Iprops.Area;
count = numel(Iprops);
maxa= area;
boundingBox = Iprops.BoundingBox;
for i=1:count
   if maxa<Iprops(i).Area
       maxa=Iprops(i).Area;
       boundingBox=Iprops(i).BoundingBox;
   end
end    

% Yukar�daki ad�m�n %'si yaz� yerini bulmak i�indir
resim = imcrop(resimbin, boundingBox);
% g�r�nt� �zerinde k�rpma i�lemi yapar.

figure; imshow(resim);  title("boundingBox sonras�");

% yaz� yeniden boyutland�r�r�z.
resim = imresize(resim, [500 NaN]);

% geni�li�i 500'den �ok uzun veya �ok k���kse baz� nesneleri kald�r�n
resim = bwareaopen(~resim, 500);

[h, w] = size(resim);
% imshow(resim);

Iprops=regionprops(resim,'BoundingBox','Area', 'Image');
count = numel(Iprops);
%numel: Iprops ��elerinin say�s�n� d�nd�r�r.

for i=1:count
     figure; imshow(Iprops(i).Image);

end



