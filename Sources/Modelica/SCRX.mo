model SCRX
  parameter Real T_AT_B = 0.1 "Ratio between regulator numerator (lead) and denominator (lag) time constants";
  parameter Real T_B = 1 "Regulator denominator (lag) time constant";
  parameter Real K = 100 "Excitation power source output gain";
  parameter Real T_E = 0.005 "Excitation power source output time constant";
  parameter Real E_MIN = -10 "Minimum exciter output";
  parameter Real E_MAX = 10 "Maximum exciter output";
  parameter Boolean C_SWITCH = false "Feeding selection. False for bus fed, and True for solid fed";
  parameter Real r_cr_fd = 10 "Ratio between crowbar circuit resistance and field circuit resistance";
  parameter Real EFD0 = 1.45;
  parameter Real ECOMP0 = 1;
  Modelica.Blocks.Interfaces.RealInput ECOMP annotation(
    Placement(transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput EFD annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback feedback annotation(
    Placement(transformation(origin = {-60, -26}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Sources.Constant VoltageReference(k = V_REF) annotation(
    Placement(transformation(origin = {70, -84}, extent = {{-170, 40}, {-150, 60}})));
  Modelica.Blocks.Math.Product product annotation(
    Placement(transformation(origin = {90, -60}, extent = {{-4, -4}, {4, 4}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = E_MAX, uMin = E_MIN)  annotation(
    Placement(transformation(origin = {76, -58}, extent = {{-4, -4}, {4, 4}})));
  Modelica.Blocks.Math.Gain gain(k = K)  annotation(
    Placement(transformation(origin = {64, -58}, extent = {{-4, -4}, {4, 4}})));
  parameter Real a0 = 1/(T_B*T_E);
  parameter Real a1 = (T_B + T_E)/(T_B*T_E);
  parameter Real b0 = 1/(T_B*T_E);
  parameter Real b1 = T_AT_B/(T_E);
  parameter Real VR0(fixed = false);
  parameter Real V_REF(fixed=false);
  Modelica.Blocks.Math.Feedback feedback2 annotation(
    Placement(transformation(origin = {-40, -27}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator integrator(y_start = 0) annotation(
    Placement(transformation(origin = {-8, -27}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator integrator1(y_start = VR0/(K*b0)) annotation(
    Placement(transformation(origin = {32, -27}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain2(k = a0) annotation(
    Placement(transformation(origin = {30, -65}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(transformation(origin = {48, -1}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain11(k = -b0) annotation(
    Placement(transformation(origin = {50, -18}, extent = {{-3, -3}, {3, 3}}, rotation = 90)));
  Modelica.Blocks.Math.Gain gain111(k = b1) annotation(
    Placement(transformation(origin = {14, -8}, extent = {{-6, -6}, {6, 6}}, rotation = 90)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(transformation(origin = {-26, -61}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
  Modelica.Blocks.Math.Gain gain1(k = a1) annotation(
    Placement(transformation(origin = {-4, -57}, extent = {{-6, -6}, {6, 6}}, rotation = 180)));
protected
initial equation
  VR0 = EFD0/ECOMP0;
  V_REF = VR0/K + ECOMP0;
equation
  connect(VoltageReference.y, feedback.u1) annotation(
    Line(points = {{-79, -34}, {-73.5, -34}, {-73.5, -26}, {-68, -26}}, color = {0, 0, 127}));
  connect(ECOMP, feedback.u2) annotation(
    Line(points = {{-100, 0}, {-60, 0}, {-60, -18}}, color = {0, 0, 127}));
  connect(EFD, product.y) annotation(
    Line(points = {{110, 0}, {97, 0}, {97, -60}, {94, -60}}, color = {0, 0, 127}));
  connect(product.u2, VoltageReference.y) annotation(
    Line(points = {{85, -62}, {85, -80.4}, {-73.8, -80.4}, {-73.8, -34}, {-79, -34}}, color = {0, 0, 127}));
  connect(limiter.y, product.u1) annotation(
    Line(points = {{80, -58}, {85, -58}}, color = {0, 0, 127}));
  connect(gain.y, limiter.u) annotation(
    Line(points = {{68, -58}, {71, -58}}, color = {0, 0, 127}));
  connect(feedback2.y, integrator.u) annotation(
    Line(points = {{-31, -27}, {-20, -27}}, color = {0, 0, 127}));
  connect(integrator.y, integrator1.u) annotation(
    Line(points = {{3, -27}, {20, -27}}, color = {0, 0, 127}));
  connect(gain2.u, integrator1.y) annotation(
    Line(points = {{37.2, -65}, {50.4, -65}, {50.4, -27}, {43.2, -27}}, color = {0, 0, 127}));
  connect(gain111.u, integrator.y) annotation(
    Line(points = {{14, -15.2}, {14, -27}, {3, -27}}, color = {0, 0, 127}));
  connect(feedback1.u1, gain111.y) annotation(
    Line(points = {{40, -1}, {14, -1}}, color = {0, 0, 127}));
  connect(gain11.y, feedback1.u2) annotation(
    Line(points = {{50, -15}, {50, -12}, {48, -12}, {48, -9}}, color = {0, 0, 127}));
  connect(add.u1, gain2.y) annotation(
    Line(points = {{-18.8, -64.6}, {23.2, -64.6}}, color = {0, 0, 127}));
  connect(add.y, feedback2.u2) annotation(
    Line(points = {{-32.6, -61}, {-39.0625, -61}, {-39.0625, -35}, {-39.6, -35}}, color = {0, 0, 127}));
  connect(gain1.u, integrator.y) annotation(
    Line(points = {{3.2, -57}, {13.4, -57}, {13.4, -27}, {3, -27}}, color = {0, 0, 127}));
  connect(gain1.y, add.u2) annotation(
    Line(points = {{-10.6, -57}, {-18.6, -57}}, color = {0, 0, 127}));
  connect(gain11.u, integrator1.y) annotation(
    Line(points = {{50, -22}, {50, -26.6}, {43, -26.6}}, color = {0, 0, 127}));
  connect(feedback2.u1, feedback.y) annotation(
    Line(points = {{-48, -26}, {-51, -26}}, color = {0, 0, 127}));
  connect(feedback1.y, gain.u) annotation(
    Line(points = {{57, -1}, {57, -2}, {59, -2}, {59, -1}, {60, -1}, {60, -58}}, color = {0, 0, 127}));
  annotation(
    uses(Modelica(version = "4.0.0"), OpenIPSL(version = "3.1.0-dev")),
  Icon(graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}), Text(origin = {17, 2}, extent = {{-63, 42}, {63, -42}}, textString = "SCRX")}));
end SCRX;
