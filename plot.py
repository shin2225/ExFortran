import numpy as np
import matplotlib.pyplot as plt

# データの読み込み (1行目はヘッダーなので飛ばす)
data = np.loadtxt('result.csv', skiprows=1)
t = data[:, 0]
x = data[:, 1]
v = data[:, 2]

# グラフ作成
plt.figure(figsize=(10, 5))

# 時系列プロット
plt.subplot(1, 2, 1)
plt.plot(t, x, label='Position (x)')
plt.plot(t, v, label='Velocity (v)')
plt.xlabel('Time')
plt.ylabel('Value')
plt.title('Time Series')
plt.legend()
plt.grid(True)

# 位相図 (Phase Portrait)
plt.subplot(1, 2, 2)
plt.plot(x, v)
plt.xlabel('x')
plt.ylabel('v')
plt.title('Phase Portrait')
plt.grid(True)
plt.axis('equal')

plt.tight_layout()
plt.savefig('output.png') # 画像として保存
plt.show()
