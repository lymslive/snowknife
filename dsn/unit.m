function st = unit()
% 生成属性单位结构体 struct
% 2015-12-10

st.hp = 200;
st.atk = 10;
st.def = 2;
st.cdef = 10;

st.eleatk = 10;
st.eledef = 2;

% 通用概率参数
st.cst = 10;
st.Acst = 0.8;
st.Bcst = 1;

st.bao = 2;
st.kbao = 2;
st.cbao = 10;
st.ckbao = 10;

st.dod = 2;
st.hit = 2;
st.cdod = 10;
st.chit = 10;

st.Abao = 0.8;
st.Bbao = 1;
st.Akbao = 0.8;
st.Bkbao = 1;
st.Ahit = 0.8;
st.Bhit = 1;
st.Adod = 0.8;
st.Bdod = 1;

st.phydef = st.def;
st.mgcdef = st.def;

end %F
