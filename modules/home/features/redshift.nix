{...}: {
  services.redshift = {
    enable = true;

    # Malmö
    latitude = 55.60587;
    longitude = 13.00073;

    temperature = {
      day = 5500;
      night = 3700;
    };
  };
}
