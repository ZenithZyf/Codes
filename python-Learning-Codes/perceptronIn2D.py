# -*- coding: utf-8 -*-
import random
import numpy as np
import matplotlib.pyplot as plt

plt.rcParams['font.sans-serif']=['SimHei'] #用来正常显示中文标签
plt.rcParams['axes.unicode_minus']=False #用来正常显示负号

#首先生成20个可分的数据，为方便起见，分别生成10个第一象限的点和10个第三象限的点
#第一象限10个点
X1=[]
Y1=[]
#第三象限10个点
X2=[]
Y2=[]
for i in range(10):
	X1.append(random.uniform(0,1))
	Y1.append(random.uniform(0,1))
	X2.append(random.uniform(-1,0))
	Y2.append(random.uniform(-1,0))

#给数据打标记,第一象限的标记为1，第三象限的标记为-1,注意添加第一个分量为1
data1=[np.array([1,X1[i],Y1[i],1]) for i in range(10)]
data2=[np.array([1,X2[i],Y2[i],-1]) for i in range(10)]
data=data1+data2

#定义sign函数
def sign(x):
	if x>=0:
		return 1
	else:
		return -1

#定义判别函数，判断所有数据是否分类完成
def Judge(x,w):
	flag=1
	for i in x:
		if sign(i[:3].dot(w))*i[-1]<0:
			flag=0
			break
	return flag

#记录次数
s=0

#初始化w=[0,0]
w=np.array([0,0,0],dtype=float)

while (Judge(data,w)==0):
	for i in data:
		if sign(i[:3].dot(w))*i[-1]<0:
			w+=i[-1]*i[:3]
			s+=1

#直线方程为w0+w1*x+w2*y=0,根据此生成点
X3=np.arange(-1,1,0.1)
Y3=np.array([(X3[i]*w[1]+w[0])/(-w[2]) for i in range(len(X3))])

#画出图片
plt.scatter(X1,Y1,c='r')
plt.scatter(X2,Y2,c='b')
plt.plot(X3,Y3)
plt.title(u"经过"+str(s)+u"次迭代收敛")
plt.show()