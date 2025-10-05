within ;
model SCRXexport
  OpenIPSL.Electrical.Controls.PSSE.ES.SCRX sCRX(
    T_AT_B=T_AT_B,
    T_B=T_B,
    K=K,
    T_E=T_E,
    E_MIN=E_MIN,
    E_MAX=E_MAX,
    C_SWITCH=C_SWITCH,
    r_cr_fd=r_cr_fd)
    annotation (Placement(transformation(extent={{18,-32},{82,32}})));
  Modelica.Blocks.Interfaces.RealInput EFD0
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  Modelica.Blocks.Interfaces.RealInput ECOMP
    annotation (Placement(transformation(extent={{-120,-20},{-80,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput XADIFD
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  parameter Real T_AT_B=0.1
    "Ratio between regulator numerator (lead) and denominator (lag) time constants";
  parameter OpenIPSL.Types.Time T_B=1
    "Regulator denominator (lag) time constant";
  parameter OpenIPSL.Types.PerUnit K=100 "Excitation power source output gain";
  parameter OpenIPSL.Types.Time T_E=0.005
    "Excitation power source output time constant";
  parameter OpenIPSL.Types.PerUnit E_MIN=-10 "Minimum exciter output";
  parameter OpenIPSL.Types.PerUnit E_MAX=10 "Maximum exciter output";
  parameter Boolean C_SWITCH=false
    "Feeding selection. False for bus fed, and True for solid fed";
  parameter Real r_cr_fd=0
    "Ratio between crowbar circuit resistance and field circuit resistance";
equation
  connect(EFD0, sCRX.ECOMP) annotation (Line(points={{-100,60},{2,60},{2,0},{
          14.8,0}},
               color={0,0,127}));
  connect(ECOMP, sCRX.EFD0) annotation (Line(points={{-100,0},{2,0},{2,-12.8},{
          14.8,-12.8}},
                   color={0,0,127}));
  connect(sCRX.EFD, y)
    annotation (Line(points={{85.2,0},{110,0}}, color={0,0,127}));
  connect(XADIFD, sCRX.XADIFD) annotation (Line(points={{-100,-60},{75.6,-60},{
          75.6,-35.2}},
                   color={0,0,127}));
  connect(const.y, sCRX.VOTHSG) annotation (Line(points={{-39,30},{-24,30},{-24,
          14},{-6,14},{-6,12.8},{14.8,12.8}}, color={0,0,127}));
  connect(sCRX.VUEL, const.y) annotation (Line(points={{37.2,-35.2},{37.2,-50},
          {-24,-50},{-24,30},{-39,30}},color={0,0,127}));
  connect(sCRX.VOEL, const.y) annotation (Line(points={{50,-35.2},{50,-50},{-24,
          -50},{-24,30},{-39,30}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={Rectangle(
            extent={{-100,100},{100,-100}}, lineColor={28,108,200})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    uses(OpenIPSL(version="3.1.0-dev"), Modelica(version="4.0.0")));
end SCRXexport;
