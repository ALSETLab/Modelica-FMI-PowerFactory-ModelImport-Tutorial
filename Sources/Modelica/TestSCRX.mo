package TestSCRX
  extends Modelica.Icons.Package;

  package Components "Package of components"
    extends Modelica.Icons.VariantsPackage;

    model SCRXwInitAsInput "Static Excitation Control System with Initialization values as Input"
      parameter Real T_AT_B = 0.1 "Ratio between regulator numerator (lead) and denominator (lag) time constants";
      parameter Real T_B = 1 "Regulator denominator (lag) time constant";
      parameter Real K = 100 "Excitation power source output gain";
      parameter Real T_E = 0.005 "Excitation power source output time constant";
      parameter Real E_MIN = -10 "Minimum exciter output";
      parameter Real E_MAX = 10 "Maximum exciter output";
      parameter Boolean C_SWITCH = false "Feeding selection. False for bus fed, and True for solid fed";
      parameter Real r_cr_fd = 10 "Ratio between crowbar circuit resistance and field circuit resistance";
      parameter Real a0 = 1/(T_B*T_E);
      parameter Real a1 = (T_B + T_E)/(T_B*T_E);
      parameter Real b0 = 1/(T_B*T_E);
      parameter Real b1 = T_AT_B/(T_E);
      //  parameter Real EFD0 = 1.45;
      //  parameter Real ECOMP0 = 1;
      Modelica.Blocks.Interfaces.RealInput ECOMP annotation(
        Placement(transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-80, 0}, extent = {{-20, -20}, {20, 20}})));
      Modelica.Blocks.Interfaces.RealOutput EFD annotation(
        Placement(transformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {150, 0}, extent = {{-10, -10}, {10, 10}})));
      Modelica.Blocks.Math.Feedback feedback annotation(
        Placement(transformation(origin = {-60, -26}, extent = {{-10, 10}, {10, -10}})));
      Modelica.Blocks.Sources.Constant VoltageReference(k = V_REF) annotation(
        Placement(transformation(origin = {70, -84}, extent = {{-170, 40}, {-150, 60}})));
      Modelica.Blocks.Math.Product product annotation(
        Placement(transformation(origin = {91, -55}, extent = {{-5, 5}, {5, -5}})));
      Modelica.Blocks.Nonlinear.Limiter limiter(uMax = E_MAX, uMin = E_MIN) annotation(
        Placement(transformation(origin = {76, -58}, extent = {{-4, -4}, {4, 4}})));
      Modelica.Blocks.Math.Gain gain(k = K) annotation(
        Placement(transformation(origin = {64, -58}, extent = {{-4, -4}, {4, 4}})));
      Modelica.Blocks.Math.Feedback feedback2 annotation(
        Placement(transformation(origin = {-36, -27}, extent = {{-10, -10}, {10, 10}})));
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
      Modelica.Blocks.Interfaces.RealInput EFD0 "Initial value of field voltage" annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-40, -120}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {-60, -120})));
      Modelica.Blocks.Interfaces.RealInput ECOMP0 "Initial value of the exciter input" annotation(
        Placement(transformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {40, -120}), iconTransformation(extent = {{-20, -20}, {20, 20}}, rotation = 90, origin = {0, -120})));
    protected
      parameter Real VR0(fixed = false);
      parameter Real V_REF(fixed = false);
    initial equation
      VR0 = EFD0/ECOMP0;
      V_REF = VR0/K + ECOMP0;
    equation
      connect(VoltageReference.y, feedback.u1) annotation(
        Line(points = {{-79, -34}, {-73.5, -34}, {-73.5, -26}, {-68, -26}}, color = {0, 0, 127}));
      connect(ECOMP, feedback.u2) annotation(
        Line(points = {{-100, 0}, {-60, 0}, {-60, -18}}, color = {0, 0, 127}));
      connect(limiter.y, product.u1) annotation(
        Line(points = {{80.4, -58}, {85, -58}}, color = {0, 0, 127}));
      connect(gain.y, limiter.u) annotation(
        Line(points = {{68.4, -58}, {71.2, -58}}, color = {0, 0, 127}));
      connect(feedback2.y, integrator.u) annotation(
        Line(points = {{-27, -27}, {-20, -27}}, color = {0, 0, 127}));
      connect(integrator.y, integrator1.u) annotation(
        Line(points = {{3, -27}, {20, -27}}, color = {0, 0, 127}));
      connect(gain2.u, integrator1.y) annotation(
        Line(points = {{37.2, -65}, {50.4, -65}, {50.4, -27}, {43, -27}}, color = {0, 0, 127}));
      connect(gain111.u, integrator.y) annotation(
        Line(points = {{14, -15.2}, {14, -27}, {3, -27}}, color = {0, 0, 127}));
      connect(feedback1.u1, gain111.y) annotation(
        Line(points = {{40, -1}, {28, -1}, {28, -1.4}, {14, -1.4}}, color = {0, 0, 127}));
      connect(gain11.y, feedback1.u2) annotation(
        Line(points = {{50, -14.7}, {50, -12}, {48, -12}, {48, -9}}, color = {0, 0, 127}));
      connect(add.u1, gain2.y) annotation(
        Line(points = {{-18.8, -64.6}, {2, -64.6}, {2, -65}, {23.4, -65}}, color = {0, 0, 127}));
      connect(add.y, feedback2.u2) annotation(
        Line(points = {{-32.6, -61}, {-39.0625, -61}, {-39.0625, -35}, {-36, -35}}, color = {0, 0, 127}));
      connect(gain1.u, integrator.y) annotation(
        Line(points = {{3.2, -57}, {13.4, -57}, {13.4, -27}, {3, -27}}, color = {0, 0, 127}));
      connect(gain1.y, add.u2) annotation(
        Line(points = {{-10.6, -57}, {-14, -57}, {-14, -57.4}, {-18.8, -57.4}}, color = {0, 0, 127}));
      connect(gain11.u, integrator1.y) annotation(
        Line(points = {{50, -21.6}, {50, -27}, {43, -27}}, color = {0, 0, 127}));
      connect(feedback2.u1, feedback.y) annotation(
        Line(points = {{-44, -27}, {-50, -27}, {-50, -26}, {-51, -26}}, color = {0, 0, 127}));
      connect(feedback1.y, gain.u) annotation(
        Line(points = {{57, -1}, {57, -2}, {59, -2}, {59, -1}, {59.2, -1}, {59.2, -58}}, color = {0, 0, 127}));
      connect(product.y, EFD) annotation(
        Line(points = {{96.5, -55}, {100, -55}, {100, 0}, {150, 0}}, color = {0, 0, 127}));
      connect(product.u2, ECOMP) annotation(
        Line(points = {{85, -52}, {80, -52}, {80, 18}, {-60, 18}, {-60, 0}, {-100, 0}}, color = {0, 0, 127}));
      annotation(
        Icon(coordinateSystem(extent = {{-100, -100}, {140, 100}}), graphics = {Rectangle(extent = {{-100, 100}, {140, -100}}), Text(origin = {39, 0}, extent = {{-63, 42}, {63, -42}}, textString = "SCRX"), Text(extent = {{-37.5, -7.5}, {37.5, 7.5}}, textColor = {28, 108, 200}, textString = "XADIFD", origin = {61.5, -71.5}, rotation = 90), Text(extent = {{-37.5, -7.5}, {37.5, 7.5}}, textColor = {28, 108, 200}, origin = {1.5, -67.5}, rotation = 90, textString = "ECOMP0"), Text(extent = {{-37.5, -7.5}, {37.5, 7.5}}, textColor = {28, 108, 200}, origin = {-58.5, -77.5}, rotation = 90, textString = "EFD0")}),
        Diagram(coordinateSystem(extent = {{-100, -100}, {140, 100}})));
    end SCRXwInitAsInput;

    model SCRXexport
      OpenIPSL.Electrical.Controls.PSSE.ES.SCRX sCRX(T_AT_B = T_AT_B, T_B = T_B, K = K, T_E = T_E, E_MIN = E_MIN, E_MAX = E_MAX, C_SWITCH = C_SWITCH, r_cr_fd = r_cr_fd) annotation(
        Placement(transformation(extent = {{18, -32}, {82, 32}})));
      Modelica.Blocks.Interfaces.RealInput EFD0 annotation(
        Placement(transformation(extent = {{-120, 40}, {-80, 80}})));
      Modelica.Blocks.Interfaces.RealInput ECOMP annotation(
        Placement(transformation(extent = {{-120, -20}, {-80, 20}})));
      Modelica.Blocks.Interfaces.RealOutput EFD annotation(
        Placement(transformation(extent = {{100, -10}, {120, 10}})));
      Modelica.Blocks.Interfaces.RealInput XADIFD annotation(
        Placement(transformation(extent = {{-120, -80}, {-80, -40}})));
      Modelica.Blocks.Sources.Constant const(k = 0) annotation(
        Placement(transformation(extent = {{-60, 20}, {-40, 40}})));
      parameter Real T_AT_B = 0.1 "Ratio between regulator numerator (lead) and denominator (lag) time constants";
      parameter OpenIPSL.Types.Time T_B = 1 "Regulator denominator (lag) time constant";
      parameter OpenIPSL.Types.PerUnit K = 100 "Excitation power source output gain";
      parameter OpenIPSL.Types.Time T_E = 0.005 "Excitation power source output time constant";
      parameter OpenIPSL.Types.PerUnit E_MIN = -10 "Minimum exciter output";
      parameter OpenIPSL.Types.PerUnit E_MAX = 10 "Maximum exciter output";
      parameter Boolean C_SWITCH = false "Feeding selection. False for bus fed, and True for solid fed";
      parameter Real r_cr_fd = 0 "Ratio between crowbar circuit resistance and field circuit resistance";
    equation
      connect(sCRX.EFD, EFD) annotation(
        Line(points = {{85.2, 0}, {110, 0}}, color = {0, 0, 127}));
      connect(XADIFD, sCRX.XADIFD) annotation(
        Line(points = {{-100, -60}, {75.6, -60}, {75.6, -35.2}}, color = {0, 0, 127}));
      connect(const.y, sCRX.VOTHSG) annotation(
        Line(points = {{-39, 30}, {-24, 30}, {-24, 14}, {-6, 14}, {-6, 12.8}, {14.8, 12.8}}, color = {0, 0, 127}));
      connect(sCRX.VUEL, const.y) annotation(
        Line(points = {{37.2, -35.2}, {37.2, -50}, {-24, -50}, {-24, 30}, {-39, 30}}, color = {0, 0, 127}));
      connect(sCRX.VOEL, const.y) annotation(
        Line(points = {{50, -35.2}, {50, -50}, {-24, -50}, {-24, 30}, {-39, 30}}, color = {0, 0, 127}));
      connect(EFD0, sCRX.EFD0) annotation(
        Line(points = {{-100, 60}, {-20, 60}, {-20, -12.8}, {14.8, -12.8}}, color = {0, 0, 127}));
      connect(ECOMP, sCRX.ECOMP) annotation(
        Line(points = {{-100, 0}, {14.8, 0}}, color = {0, 0, 127}));
      annotation(
        Icon(coordinateSystem(preserveAspectRatio = false), graphics = {Rectangle(extent = {{-100, 100}, {100, -100}}, lineColor = {28, 108, 200}), Text(extent = {{-76, 84}, {46, 36}}, textColor = {28, 108, 200}, textString = "EFD0"), Text(extent = {{-70, 26}, {52, -22}}, textColor = {28, 108, 200}, textString = "ECOMP"), Text(extent = {{-74, -36}, {48, -84}}, textColor = {28, 108, 200}, textString = "XADIFD")}),
        Diagram(coordinateSystem(preserveAspectRatio = false)));
    end SCRXexport;
  end Components;

  package Experiments
    extends Modelica.Icons.ExamplesPackage;

    model TestWithOpenIPSLInitAsInput
      extends OpenIPSL.Tests.BaseClasses.SMIB(pwFault(t1 = 2, t2 = 2.15), GEN1(v_0 = 1));
      OpenIPSL.Electrical.Machines.PSSE.GENROU gENROU(D = 0, H = 4.28, M_b = 100000000, P_0 = 40000000, Q_0 = 5416582, R_a = 0, S10 = 0.11, S12 = 0.39, Tpd0 = 5, Tppd0 = 0.07, Tppq0 = 0.09, Tpq0 = 0.9, Xd = 1.84, Xl = 0.12, Xpd = 0.41, Xpp = 0.2, Xppd = 0.2, Xppq = 0.2, Xpq = 0.6, Xq = 1.75, angle_0 = 0.070492225331847, v_0 = 1) annotation(
        Placement(transformation(origin = {-8.8, 0}, extent = {{-57.2, -13}, {-31.2, 13}})));
      Components.SCRXwInitAsInput sCRXwInitAsInput(r_cr_fd = 0) annotation(
        Placement(transformation(extent = {{-100, -18}, {-80, 2}})));
    equation
      connect(GEN1.p, gENROU.p) annotation(
        Line(points = {{-30, 0}, {-40, 0}}, color = {0, 0, 255}));
      connect(gENROU.PMECH, gENROU.PMECH0) annotation(
        Line(points = {{-68.6, 7.8}, {-76, 7.8}, {-76, 20}, {-36, 20}, {-36, 6.5}, {-38.7, 6.5}}, color = {0, 0, 127}));
      connect(sCRXwInitAsInput.EFD0, gENROU.EFD0) annotation(
        Line(points = {{-96.6667, -20}, {-96, -20}, {-96, -28}, {-32, -28}, {-32, -6.5}, {-38.7, -6.5}}, color = {0, 0, 127}));
      connect(sCRXwInitAsInput.ECOMP0, gENROU.ETERM) annotation(
        Line(points = {{-91.6667, -20}, {-92, -20}, {-92, -26}, {-22, -26}, {-22, -3.9}, {-38.7, -3.9}}, color = {0, 0, 127}));
      connect(sCRXwInitAsInput.ECOMP, gENROU.ETERM) annotation(
        Line(points = {{-98.3333, -8}, {-108, -8}, {-108, -34}, {-22, -34}, {-22, -3.9}, {-38.7, -3.9}}, color = {0, 0, 127}));
  connect(sCRXwInitAsInput.EFD, gENROU.EFD) annotation(
        Line(points = {{-80, -8}, {-68, -8}}, color = {0, 0, 127}));
      annotation(
        experiment(StopTime = 10, __Dymola_Algorithm = "Dassl"));
    end TestWithOpenIPSLInitAsInput;

    model TestWithOpenIPSLOriginalSCRX
      extends OpenIPSL.Tests.Controls.PSSE.ES.SCRX(pwFault(t1 = 2, t2 = 2.15));
    equation

    end TestWithOpenIPSLOriginalSCRX;
  end Experiments;
  annotation(
    uses(Modelica(version = "4.0.0"), OpenIPSL(version = "3.1.0-dev")));
end TestSCRX;
