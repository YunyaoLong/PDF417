%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%����֮ǰ�����ȱ�ɻҶ�ͼ
%OTSU �����䷽�ͼ�����  
%�÷�����ͼ���Ϊǰ���ͱ��������֣�������Ŀ��֮�����䷽��Խ��,˵������ͼ���2���ֵĲ��Խ��,  
%������Ŀ�����Ϊ�����򲿷ֱ�������ΪĿ�궼�ᵼ��2���ֲ���С�����,ʹ��䷽�����ķָ���ζ�Ŵ��ָ�����С��  
%Command �е��÷�ʽ�� OTSU('D:\Images\pic_loc\1870405130305041503.jpg')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
function [maxgrey, Pic] = otsu(Pic)
	%[Count x]=imhist(a);
	[Row, Col] = size(Pic);
	L = 256; %256���Ҷȼ�

	%Count��һ�����飬�����ÿһ���Ҷ�ֵ�����������±�-1����ʾ��Ӧ�ĻҶ�ֵ
	%x��һ�����飬������š��Ҷ�ֵ��
	[Count, x] = imhist(Pic);

	Count = Count / (Row*Col);	%ÿһ���Ҷ�ֵ��Ƶ��


	for i = 1 : L
		if Count(i) ~= 0		%��һ����Ϊ0�ĻҶ�ֵ���±�
			start_index = i;	%�ûҶ�ֵ��ע�⡾�±�-1����ʾ��Ӧ�ĻҶ�ֵ
			break;
		end
	end

	for i = L : -1 : 1
		if Count(i) ~= 0		%������һ����Ϊ0�ĻҶ�ֵ���±�
			end_index = i;		%�ûҶ�ֵ
			break;
		end
	end

	%Count��ÿ���Ҷȳ��ֵġ����ʡ�
	%ȥ��0ֵ��Ϊ�˷���֮��ķ������
	Count = Count(start_index: end_index);
	x = x(start_index: end_index);

	%t֮ǰ�ı���Ϊǰ�����أ�t֮��ı���Ϊ��������
	%����PPT��matlab������Ϊ���ܲ���Խ����Ϊ
    u0 = zeros(end_index-start_index+1, 1);
    u1 = zeros(end_index-start_index+1, 1);
	for t = 1 : end_index-start_index+1
		%w0(i)��ǰi�����ص��ۼӸ���
		w0(t) = sum(Count(1 : t));
		%(start_index + t - 1)��ʾ��ǰ�ĻҶ�ֵ
		%u0(i)��ǰi������q����ֵ
        %PPT������������
		u0(t) = sum(Count(1 : t) .* x(1 : t))/w0(t);
        if(t == end_index-start_index+1)
            u1(t) = 0;
		else u1(t) = sum(Count(t+1 : end_index-start_index+1) .* x(t+1 : end_index-start_index+1))/(1-w0(t));
        end
    end

	%u��������ͼ�������
	u = u0(end_index-start_index+1);
	%����PPT��matlab�����д���Ҫ����PPT�Ĺ�ʽ��д����
	%g��ʾÿ������ֵ����Ӧ�ĵ�������ֵ
	%g = (u * w0 - u0) .^ 2 ./ (w0 .* (1 - w0));
    for t = 1 : end_index-start_index+1
        g = (u0(t)-u)*(u0(t)-u)*(u1(t)-u)*(u1(t)-u);
    end

	%�ҵ���ѷ�ֵ
	[g_max, g_index] = max(g);  %����ȡ����������ֵ��ȡ���ֵ�ĵ�   
	%max��ʾ���ķ�ֵ����Ӧ�ĻҶ�ֵ���±�
    maxgrey = x(g_index); %�ҵ���Ӧ�ĻҶ�ֵ
	  
	for i = 1 : Row
		for j = 1 : Col
			if Pic(i, j) > maxgrey
				Pic(i, j) = 255;
			else
				Pic(i, j) = 0;
			end
		end
	end
	%subplot(212);
end