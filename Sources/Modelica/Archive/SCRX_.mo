model SCRX
  parameter Real T_AT_B = 0.1 "Ratio between regulator numerator (lead) and denominator (lag) time constants";
  parameter Real T_B = 1 "Regulator denominator (lag) time constant";
  parameter Real K = 100 "Excitation power source output gain";
  parameter Real T_E = 0.005 "Excitation power source output time constant";
  parameter Real E_MIN = -10 "Minimum exciter output";
  parameter Real E_MAX = 10 "Maximum exciter output";
  parameter Boolean C_SWITCH = false "Feeding selection. False for bus fed, and True for solid fed";
  parameter Real r_cr_fd = 0 "Ratio between crowbar circuit resistance and field circuit resistance";


  Modelica.Blocks.Math.Add DiffV(k2 = -1) annotation(
    Placement(transformation(origin = {-15, 0}, extent = {{-48, -4}, {-40, 4}})));
  Modelica.Blocks.Math.Add3 V_erro annotation(
    Placement(transformation(origin = {-27, 0}, extent = {{-24, -4}, {-16, 4}})));
  OpenIPSL.NonElectrical.Logical.NegCurLogic negCurLogic(RC_rfd = r_cr_fd, nstartvalue = EFD0) annotation(
    Placement(transformation(origin = {-23, 0}, extent = {{90, -6}, {108, 6}})));
  Modelica.Blocks.Logical.Switch switch1 annotation(
    Placement(transformation(origin = {-55, 14}, extent = {{72, 18}, {84, 30}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k = C_SWITCH) annotation(
    Placement(transformation(origin = {-73, -6}, extent = {{40, 46}, {52, 58}})));
  Modelica.Blocks.Math.Product product annotation(
    Placement(transformation(origin = {-40, 16.3333}, extent = {{35, 11.6667}, {45, 21.6667}})));
  Modelica.Blocks.Math.Add DiffV1(k2 = -1) annotation(
    Placement(transformation(origin = {-53, -12}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax = E_MAX, uMin = E_MIN) annotation(
    Placement(transformation(origin = {43, 0}, extent = {{-4, -4}, {4, 4}})));
  Modelica.Blocks.Math.Gain gain(k = K) annotation(
    Placement(transformation(origin = {29, 0}, extent = {{-4, -4}, {4, 4}})));
  Modelica.Blocks.Math.Feedback feedback2 annotation(
    Placement(transformation(origin = {-34, 0}, extent = {{-7, -7}, {7, 7}})));
  Modelica.Blocks.Continuous.Integrator integrator(y_start = 0) annotation(
    Placement(transformation(origin = {-18, 0}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Continuous.Integrator integrator1(y_start = VR0/(K*b0)) annotation(
    Placement(transformation(origin = {2, 0}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Math.Gain gain2(k = a0) annotation(
    Placement(transformation(origin = {3, -19}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.Feedback feedback1 annotation(
    Placement(transformation(origin = {14, 22}, extent = {{-5, -5}, {5, 5}})));
  Modelica.Blocks.Math.Gain gain11(k = -b0) annotation(
    Placement(transformation(origin = {14, 11}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  Modelica.Blocks.Math.Gain gain111(k = b1) annotation(
    Placement(transformation(origin = {-1, 14}, extent = {{-4, -4}, {4, 4}}, rotation = 90)));
  Modelica.Blocks.Math.Add add annotation(
    Placement(transformation(origin = {-23, -17}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Blocks.Math.Gain gain1(k = a1) annotation(
    Placement(transformation(origin = {-11, -13}, extent = {{-4, -4}, {4, 4}}, rotation = 180)));
  Modelica.Blocks.Interfaces.RealInput Voel annotation(
    Placement(transformation(origin = {-100, -52}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput Vuel annotation(
    Placement(transformation(origin = {-100, -38}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput dVref annotation(
    Placement(transformation(origin = {-100, 22}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, 46}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput Ec annotation(
    Placement(transformation(origin = {-100, -2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput Vs annotation(
    Placement(transformation(origin = {-100, 58}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, 26}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput Vt annotation(
    Placement(transformation(origin = {-100, 74}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, 86}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput Ifd annotation(
    Placement(transformation(origin = {-100, -66}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-90, -80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add DiffV2(k2 = -1) annotation(
    Placement(transformation(origin = {-27, 30}, extent = {{-48, -4}, {-40, 4}})));
  Modelica.Blocks.Interfaces.RealOutput Efd annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealInput Ec0 annotation(
    Placement(transformation(origin = {-80, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {-30, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput Efd0 annotation(
    Placement(transformation(origin = {-60, -100}, extent = {{-10, -10}, {10, 10}}, rotation = 90), iconTransformation(origin = {30, -90}, extent = {{-10, -10}, {10, 10}}, rotation = 90)));

protected
  parameter Real VR0(fixed = false);
  parameter Real V_REF(fixed = false);
  parameter Real EFD0(fixed = false);
  parameter Real a0 = 1/(T_B*T_E);
  parameter Real a1 = (T_B + T_E)/(T_B*T_E);
  parameter Real b0 = 1/(T_B*T_E);
  parameter Real b1 = T_AT_B/(T_E);public
  Modelica.Blocks.Sources.Constant VoltageReference(k = V_REF) annotation(
    Placement(transformation(origin = {-10, 15}, extent = {{-85, 20}, {-75, 30}})));
initial equation
  EFD0 = Efd0;
  if not C_SWITCH then
    VR0 = Efd0/Ec0;
    V_REF = VR0/K + Ec0;
  else
    VR0 = Efd0;
    V_REF = VR0/K + Ec0;
  end if;
equation
  connect(booleanConstant.y, switch1.u2) annotation(
    Line(points = {{-20.4, 46}, {10.2, 46}, {10.2, 38}, {15.6, 38}}, color = {255, 0, 255}));
  connect(product.y, switch1.u3) annotation(
    Line(points = {{5.5, 33}, {16, 33}}, color = {0, 0, 127}));
  connect(DiffV.y, V_erro.u2) annotation(
    Line(points = {{-54.6, 0}, {-51.6, 0}}, color = {0, 0, 127}));
  connect(DiffV1.y, V_erro.u3) annotation(
    Line(points = {{-53, -7.6}, {-53, -2.7}, {-52, -2.7}, {-52, -2.6}}, color = {0, 0, 127}));
  connect(gain.y, limiter.u) annotation(
    Line(points = {{33.4, 0}, {38, 0}}, color = {0, 0, 127}));
  connect(feedback2.y, integrator.u) annotation(
    Line(points = {{-27.7, 0}, {-23.7, 0}}, color = {0, 0, 127}));
  connect(integrator.y, integrator1.u) annotation(
    Line(points = {{-12.5, 0}, {-4, 0}}, color = {0, 0, 127}));
  connect(gain2.u, integrator1.y) annotation(
    Line(points = {{7.8, -19}, {11.2, -19}, {11.2, 0}, {7.5, 0}}, color = {0, 0, 127}));
  connect(gain111.u, integrator.y) annotation(
    Line(points = {{-1, 9.2}, {-1, 0.4}, {-12.5, 0.4}}, color = {0, 0, 127}));
  connect(feedback1.u1, gain111.y) annotation(
    Line(points = {{10, 22}, {-2.125, 22}, {-2.125, 18}, {-1, 18}}, color = {0, 0, 127}));
  connect(gain11.y, feedback1.u2) annotation(
    Line(points = {{14, 15.4}, {14, 18.4}}, color = {0, 0, 127}));
  connect(add.u1, gain2.y) annotation(
    Line(points = {{-18.2, -19.4}, {-1.2, -19.4}}, color = {0, 0, 127}));
  connect(add.y, feedback2.u2) annotation(
    Line(points = {{-27.4, -17}, {-30.463, -17}, {-30.463, -6}, {-34, -6}}, color = {0, 0, 127}));
  connect(gain1.u, integrator.y) annotation(
    Line(points = {{-6.2, -13}, {-3.8, -13}, {-3.8, 0}, {-12.5, 0}}, color = {0, 0, 127}));
  connect(gain1.y, add.u2) annotation(
    Line(points = {{-15.4, -13}, {-16.9, -13}, {-16.9, -15}, {-18.4, -15}}, color = {0, 0, 127}));
  connect(gain11.u, integrator1.y) annotation(
    Line(points = {{14, 6.2}, {14, 0}, {7.5, 0}}, color = {0, 0, 127}));
  connect(feedback1.y, gain.u) annotation(
    Line(points = {{18.5, 22}, {22.25, 22}, {22.25, 0}, {24, 0}}, color = {0, 0, 127}));
  connect(limiter.y, product.u2) annotation(
    Line(points = {{47.4, 0}, {47.8, 0}, {47.8, 10}, {26.1, 10}, {26.1, 26}, {-16.95, 26}, {-16.95, 30}, {-6, 30}}, color = {0, 0, 127}));
  connect(V_erro.y, feedback2.u1) annotation(
    Line(points = {{-42.6, 0}, {-39.2, 0}}, color = {0, 0, 127}));
  connect(switch1.u1, limiter.y) annotation(
    Line(points = {{15.8, 42.8}, {47.4, 42.8}, {47.4, -0.4}, {46.6, -0.4}}, color = {0, 0, 127}));
  connect(Vuel, DiffV1.u1) annotation(
    Line(points = {{-100, -38}, {-56, -38}, {-56, -16}}, color = {0, 0, 127}));
  connect(Voel, DiffV1.u2) annotation(
    Line(points = {{-100, -52}, {-50, -52}, {-50, -16}}, color = {0, 0, 127}));
  connect(Ifd, negCurLogic.XadIfd) annotation(
    Line(points = {{-100, -66}, {52, -66}, {52, -4}, {65, -4}}, color = {0, 0, 127}));
  connect(Ec, DiffV.u2) annotation(
    Line(points = {{-100, -2}, {-64, -2}}, color = {0, 0, 127}));
  connect(dVref, DiffV2.u2) annotation(
    Line(points = {{-100, 22}, {-84, 22}, {-84, 28}, {-76, 28}}, color = {0, 0, 127}));
  connect(DiffV2.y, DiffV.u1) annotation(
    Line(points = {{-67, 30}, {-64, 30}, {-64, 2}}, color = {0, 0, 127}));
  connect(Vs, V_erro.u1) annotation(
    Line(points = {{-100, 58}, {-52, 58}, {-52, 4}}, color = {0, 0, 127}));
  connect(Vt, product.u1) annotation(
    Line(points = {{-100, 74}, {-44, 74}, {-44, 36}, {-6, 36}}, color = {0, 0, 127}));
  connect(VoltageReference.y, DiffV2.u1) annotation(
    Line(points = {{-84, 40}, {-80, 40}, {-80, 32}, {-76, 32}}, color = {0, 0, 127}));
  connect(negCurLogic.Vd, switch1.y) annotation(
    Line(points = {{66, 4}, {52, 4}, {52, 38}, {30, 38}}, color = {0, 0, 127}));
  connect(negCurLogic.Efd, Efd) annotation(
    Line(points = {{86, 0}, {110, 0}}, color = {0, 0, 127}));

annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Text(origin = {-58, 88}, extent = {{-44, 12}, {44, -12}}, textString = "Vt"), Text(origin = {-58, 68}, extent = {{-44, 12}, {44, -12}}, textString = "Vref"), Text(origin = {-58, 48}, extent = {{-44, 12}, {44, -12}}, textString = "dVref"), Text(origin = {-58, 68}, extent = {{-44, 12}, {44, -12}}, textString = "Vref"), Text(origin = {-58, 26}, extent = {{-44, 12}, {44, -12}}, textString = "Vs"), Text(origin = {-58, 0}, extent = {{-44, 12}, {44, -12}}, textString = "Ec"), Text(origin = {-60, -30}, extent = {{-44, 12}, {44, -12}}, textString = "Voel"), Text(origin = {-60, -48}, extent = {{-44, 12}, {44, -12}}, textString = "Vuel"), Text(origin = {-60, -80}, extent = {{-44, 12}, {44, -12}}, textString = "Ifd"), Text(origin = {-30, -62}, rotation = 90, extent = {{-44, 12}, {44, -12}}, textString = "Ec0"), Text(origin = {30, -62}, rotation = 90, extent = {{-44, 12}, {44, -12}}, textString = "Efd0"), Rectangle(extent = {{-100, 100}, {100, -100}})}),
    Diagram(graphics));
end SCRX;
