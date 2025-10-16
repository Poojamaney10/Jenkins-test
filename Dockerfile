# Use official Tomcat base image
FROM tomcat:9.0-jdk17-temurin

# Switch to root temporarily to perform setup
USER root

# Remove default ROOT application (optional)
RUN rm -rf /usr/local/tomcat/webapps/*

# Create a non-root user and group for Tomcat
RUN groupadd -r tomcat && useradd -r -g tomcat tomcat

# Set permissions for Tomcat directories
RUN chown -R tomcat:tomcat /usr/local/tomcat

# Copy your WAR file into Tomcat's webapps directory
COPY target/*.war /usr/local/tomcat/webapps/ROOT.war

# Ensure permissions for the copied file
RUN chown tomcat:tomcat /usr/local/tomcat/webapps/ROOT.war

# Expose Tomcat port
EXPOSE 8080

# Switch to non-root user
USER tomcat

# Start Tomcat
CMD ["catalina.sh", "run"]
