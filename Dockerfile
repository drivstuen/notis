# Stage 1: Build the React application
FROM node:22-alpine AS build
WORKDIR /app

# Copy both package.json and yarn.lock
COPY package.json yarn.lock ./

# Use Yarn's equivalent of a clean install
RUN yarn install --frozen-lockfile

COPY . ./

# Build using Yarn
RUN yarn build

# Stage 2: Serve the application with Nginx (remains the same)
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]