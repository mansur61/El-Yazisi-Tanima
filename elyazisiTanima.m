
resim = imread('elYazisi5.png'); // Ýstenilen resmi bu kýsma yazýnýz

resimgray = rgb2gray(resim);

resimbin = imbinarize(resimgray);

resim = edge(resimgray, 'sobel');

resim = imdilate(resim,strel('diamond',5));
% imdilate ile strel ile yapýlan morfolojik iþlemlerin
%açma iþlemini gerçekleþtirdik. Kapama iþlemi ise imeorde ile
%yapýlmaktadýr.

resim = imfill(resim, 'holes');
% morfolojik iþlemelerden gelen istenmeyen boþluklarýn doldurulmasý 
%iþlemlerinþ imfill ile yapýyoruz. Yaparkende diyoruz ki boþluklarý holes
%adlý özelliði ile doldur veya düzelt.(Boþluktan kasýt gürültü)

resim = imerode(resim, strel('diamond',3)); 
%Morfolojik iþlmelerde kapama iþlemi yapýldý.

Iprops=regionprops(resim,'BoundingBox','Area', 'Image'); 
% Burada kullanýlan regionprops özelliði ile de
%görüntüde almak istediðimiz nesneleri koparýp ayrý figüre olarak
%göstermeye çalýþtýk.

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

% Yukarýdaki adýmýn %'si yazý yerini bulmak içindir
resim = imcrop(resimbin, boundingBox);
% görüntü üzerinde kýrpma iþlemi yapar.

figure; imshow(resim);  title("boundingBox sonrasý");

% yazý yeniden boyutlandýrýrýz.
resim = imresize(resim, [500 NaN]);

% geniþliði 500'den çok uzun veya çok küçükse bazý nesneleri kaldýrýn
resim = bwareaopen(~resim, 500);

[h, w] = size(resim);
% imshow(resim);

Iprops=regionprops(resim,'BoundingBox','Area', 'Image');
count = numel(Iprops);
%numel: Iprops öðelerinin sayýsýný döndürür.

for i=1:count
     figure; imshow(Iprops(i).Image);

end



